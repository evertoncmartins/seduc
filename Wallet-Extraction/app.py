import re
import io
from flask import Flask, request, jsonify
from flask_cors import CORS
import pdfplumber
from pdf2image import convert_from_bytes
import pytesseract

app = Flask(__name__)
CORS(app)

POPPLER_PATH = None  # Caminho do Poppler no Windows, se necessário

# ---------------- OCR ----------------
def extract_text_with_ocr(file_bytes):
    pages = convert_from_bytes(file_bytes, poppler_path=POPPLER_PATH)
    text = ""
    for page in pages:
        text += pytesseract.image_to_string(page, lang='por')
    return text

# ---------------- Parser ----------------
def extract_data_from_brokerage_note(text: str):
    lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
    flat = " ".join(lines)

    data_operacao = "Não encontrado"
    corretora = "Não encontrado"
    irrf = "0,00" # Valor padrão
    total_taxas = 0.0

    m = re.search(r'(?:Preg[aã]o|Data)\D*(\d{2}/\d{2}/\d{4})', flat, re.IGNORECASE)
    if not m: m = re.search(r'\b(\d{2}/\d{2}/\d{4})\b', flat)
    if m: data_operacao = m.group(1)

    m = re.search(r'(XP INVESTIMENTOS|CLEAR CORRETORA|NU INVEST|MODALMAIS)', flat, re.IGNORECASE)
    if m: corretora = m.group(1).title()

    m = re.search(r'(?:IRRF|I\.?R\.?R\.?F)\s*(?:day\s*trade|s/?\s*opera[çc][õo]es)?\D*(\d{1,3}(?:\.\d{3})*,\d{2}|\d+,\d{2})', flat, re.IGNORECASE)
    if m: irrf = m.group(1)

    for kw in ['Taxa de liquidação', 'Emolumentos', 'Taxa operacional', 'Outros']:
        mt = re.search(rf'{kw}.*?(\d{{1,3}}(?:\.\d{{3}})*,\d{{2}}|\d+,\d{{2}})', flat, re.IGNORECASE)
        if mt:
            valor = mt.group(1).replace('.', '').replace(',', '.')
            total_taxas += float(valor)

    negociacoes = []
    ticker_regex = re.compile(r'\b([A-Z]{4}\d{1,2})\b')

    for i, ln in enumerate(lines):
        tick_match = ticker_regex.search(ln)
        if tick_match:
            ticker = tick_match.group(1)
            qtd, preco, operacao = None, None, "Não encontrado"

            if re.search(r'\bC\b', ln): operacao = "Compra"
            elif re.search(r'\bV\b', ln): operacao = "Venda"
            
            pattern_string = re.escape(ticker) + r'\D+(\d+)\D+(?:R\$\s*)?(\d{1,3}(?:\.\d{3})*,\d{2})'
            qp_match = re.search(pattern_string, ln)

            if qp_match:
                qtd, preco = qp_match.group(1), qp_match.group(2)
            else:
                qtd_match = re.search(rf'{re.escape(ticker)}\D+(\d+)', ln)
                if qtd_match: qtd = qtd_match.group(1)
                preco_match = re.search(r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})', ln, re.IGNORECASE)
                if not preco_match and i + 1 < len(lines):
                    preco_match = re.search(r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})', lines[i+1], re.IGNORECASE)
                if preco_match: preco = preco_match.group(1)

            negociacoes.append({
                "Ativo": ticker, "Operacao": operacao,
                "Quantidade": qtd if qtd else "Não encontrado",
                "Valor Unitário": preco if preco else "Não encontrado"
            })

    return {
        "Data da Operação": data_operacao, "Corretora": corretora,
        "IRRF": irrf, 
        "Total Taxas": f"{total_taxas:.2f}".replace('.', ','),
        "Negociacoes": negociacoes
    }

# ---------------- Endpoint ----------------
@app.route('/api/extract_data', methods=['POST'])
def handle_file_upload():
    files = request.files.getlist('file')
    if not files or all(f.filename == '' for f in files):
        return jsonify({'error': 'Nenhum arquivo enviado'}), 400

    processed_notes = []
    for file in files:
        if file and file.filename.lower().endswith('.pdf'):
            try:
                file_bytes = file.read()
                text = ""
                try:
                    with pdfplumber.open(io.BytesIO(file_bytes)) as pdf:
                        for page in pdf.pages:
                            t = page.extract_text(); 
                            if t: text += t + "\n"
                except Exception: text = ""
                if not text.strip(): text = extract_text_with_ocr(file_bytes)
                if text.strip(): processed_notes.append(extract_data_from_brokerage_note(text))
            except Exception: continue
    
    flat_trades = []
    for note in processed_notes:
        corretora_transformed = "XPI" if note.get("Corretora") == "Xp Investimentos" else note.get("Corretora")
        
        # --- INÍCIO DA LÓGICA DE TAXA PROPORCIONAL ---
        total_taxas_nota_float = float(note.get("Total Taxas", "0,00").replace(',', '.'))
        
        # 1. Calcula o valor total da nota e armazena o valor de cada operação
        valor_total_nota = 0
        operacoes_com_valor = []
        for trade in note.get("Negociacoes", []):
            try:
                quantidade = int(trade.get("Quantidade", 0))
                preco = float(trade.get("Valor Unitário", "0").replace(',', '.'))
                valor_operacao = quantidade * preco
                valor_total_nota += valor_operacao
                operacoes_com_valor.append({"trade": trade, "valor_operacao": valor_operacao})
            except (ValueError, TypeError):
                operacoes_com_valor.append({"trade": trade, "valor_operacao": 0})

        # 2. Itera sobre as operações para montar a saída com a taxa proporcional
        for item in operacoes_com_valor:
            trade = item["trade"]
            valor_operacao = item["valor_operacao"]
            
            taxa_proporcional = 0
            if valor_total_nota > 0:
                proporcao = valor_operacao / valor_total_nota
                taxa_proporcional = total_taxas_nota_float * proporcao
            
            taxa_proporcional_str = f"{taxa_proporcional:.2f}".replace('.', ',')
            # --- FIM DA LÓGICA DE TAXA PROPORCIONAL ---

            operacao_transformed = "C" if trade.get("Operacao") == "Compra" else ("V" if trade.get("Operacao") == "Venda" else trade.get("Operacao"))
            
            flat_trades.append({
                "Data da operação": note.get("Data da Operação"),
                "Operação": operacao_transformed,
                "Ticker": trade.get("Ativo"),
                "Quantidade negociado": trade.get("Quantidade"),
                "Preço unitário negociado": trade.get("Valor Unitário"),
                "Taxas": taxa_proporcional_str, # <- Usa o novo valor calculado
                "IRRF": note.get("IRRF"),
                "Split Ratio": "1",
                "Corretora": corretora_transformed
            })

    return jsonify(flat_trades)

if __name__ == '__main__':
    app.run(debug=True)
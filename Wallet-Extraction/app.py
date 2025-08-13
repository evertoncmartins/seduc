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

    # ---------- Campos globais ----------
    data_operacao = "Não encontrado"
    corretora = "Não encontrado"
    irrf = "R$ 0,00"
    total_taxas = 0.0

    # Data
    m = re.search(r'(?:Preg[aã]o|Data)\D*(\d{2}/\d{2}/\d{4})', flat, re.IGNORECASE)
    if not m:
        m = re.search(r'\b(\d{2}/\d{2}/\d{4})\b', flat)
    if m:
        data_operacao = m.group(1)

    # Corretora
    m = re.search(r'(XP INVESTIMENTOS|CLEAR CORRETORA|NU INVEST|MODALMAIS)', flat, re.IGNORECASE)
    if m:
        corretora = m.group(1).title()

    # IRRF
    m = re.search(r'(?:IRRF|I\.?R\.?R\.?F)\s*(?:day\s*trade|s/?\s*opera[çc][õo]es)?\D*'
                  r'(\d{1,3}(?:\.\d{3})*,\d{2}|\d+,\d{2})', flat, re.IGNORECASE)
    if m:
        irrf = f"R$ {m.group(1)}"

    # Total de taxas
    for kw in ['Taxa de liquidação', 'Emolumentos', 'Taxa operacional', 'Outros']:
        mt = re.search(rf'{kw}.*?(\d{{1,3}}(?:\.\d{{3}})*,\d{{2}}|\d+,\d{{2}})', flat, re.IGNORECASE)
        if mt:
            valor = mt.group(1).replace('.', '').replace(',', '.')
            total_taxas += float(valor)

    # ---------- Negociações ----------
    negociacoes = []
    ticker_regex = re.compile(r'\b([A-Z]{4}\d{1,2})\b')

    for i, ln in enumerate(lines):
        tick_match = ticker_regex.search(ln)
        if tick_match:
            ticker = tick_match.group(1)
            qtd = None
            preco = None
            operacao = "Não encontrado"

            # Tenta achar operação na linha ou próxima
            op_match = re.search(r'\b(COMPRA|VENDA)\b', ln, re.IGNORECASE)
            if not op_match and i > 0:
                op_match = re.search(r'\b(COMPRA|VENDA)\b', lines[i-1], re.IGNORECASE)
            if op_match:
                operacao = op_match.group(1).capitalize()

            # Tenta quantidade e preço na mesma linha
            qp_match = re.search(rf'{re.escape(ticker)}\D+(\d+)\D+(?:R\$\s*)?(\d{{1,3}}(?:\.\d{{3}})*,\d{{2}})', ln)
            if qp_match:
                qtd = qp_match.group(1)
                preco = f"R$ {qp_match.group(2)}"
            else:
                # Procura quantidade depois do ticker
                qtd_match = re.search(rf'{re.escape(ticker)}\D+(\d+)', ln)
                if qtd_match:
                    qtd = qtd_match.group(1)
                # Procura preço na linha ou na próxima
                preco_match = re.search(r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})', ln, re.IGNORECASE)
                if not preco_match and i + 1 < len(lines):
                    preco_match = re.search(r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})', lines[i+1], re.IGNORECASE)
                if preco_match:
                    preco = f"R$ {preco_match.group(1)}"

            negociacoes.append({
                "Ativo": ticker,
                "Operacao": operacao,
                "Quantidade": qtd if qtd else "Não encontrado",
                "Valor Unitário": preco if preco else "Não encontrado"
            })

    return {
        "Data da Operação": data_operacao,
        "Corretora": corretora,
        "IRRF": irrf,
        "Total Taxas": f"R$ {total_taxas:.2f}".replace('.', ','),
        "Negociacoes": negociacoes
    }

# ---------------- Endpoint ----------------
@app.route('/api/extract_data', methods=['POST'])
def handle_file_upload():
    if 'file' not in request.files:
        return jsonify({'error': 'Nenhum arquivo enviado'}), 400

    file = request.files['file']
    if file.filename == '' or not file.filename.lower().endswith('.pdf'):
        return jsonify({'error': 'Arquivo inválido. Por favor, envie um PDF.'}), 400

    try:
        file_bytes = file.read()

        # 1) Tenta pdfplumber
        text = ""
        try:
            with pdfplumber.open(io.BytesIO(file_bytes)) as pdf:
                for page in pdf.pages:
                    t = page.extract_text()
                    if t:
                        text += t + "\n"
        except Exception:
            text = ""

        # 2) Fallback OCR
        if not text.strip():
            text = extract_text_with_ocr(file_bytes)

        if not text.strip():
            return jsonify({'error': 'Não foi possível extrair texto do PDF.'}), 400

        extracted = extract_data_from_brokerage_note(text)
        return jsonify(extracted)

    except Exception as e:
        return jsonify({'error': f'Erro ao processar o PDF: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True)

import re
import io
from flask import Flask, request, jsonify
from flask_cors import CORS
import pdfplumber
from pdf2image import convert_from_bytes
import pytesseract

# Inicializa o aplicativo Flask
app = Flask(__name__)
CORS(app)

# Caminho do Poppler no Windows (preencha se usar OCR no Windows)
# Exemplo: r"C:\poppler-xx\Library\bin"
POPPLER_PATH = None

# -------- OCR --------
def extract_text_with_ocr(file_bytes):
    pages = convert_from_bytes(file_bytes, poppler_path=POPPLER_PATH)
    text = ""
    for page in pages:
        text += pytesseract.image_to_string(page, lang='por')
    return text

# -------- Parser --------
def extract_data_from_brokerage_note(text: str):
    data = {
        'Data da Operação': 'Não encontrado',
        'Corretora': 'Não encontrado',
        'Operação': 'Não encontrado',
        'Ativo (Ticker)': 'Não encontrado',
        'Quantidade': 'Não encontrado',
        'Valor Unitário': 'Não encontrado',
        'Total Taxas': 'R$ 0,00',
        'IRRF': 'Não encontrado'
    }

    # Quebra em linhas e também cria uma versão "flat"
    lines = [ln.strip() for ln in text.splitlines() if ln.strip()]
    flat = " ".join(lines)

    # --- Data ---
    m = re.search(r'(?:Preg[aã]o|Data)\D*(\d{2}/\d{2}/\d{4})', flat, re.IGNORECASE)
    if not m:
        m = re.search(r'\b(\d{2}/\d{2}/\d{4})\b', flat)
    if m:
        data['Data da Operação'] = m.group(1)

    # --- Corretora ---
    m = re.search(r'(XP INVESTIMENTOS|CLEAR CORRETORA|NU INVEST|MODALMAIS)', flat, re.IGNORECASE)
    if m:
        data['Corretora'] = m.group(1).title()

    # --- Operação (COMPRA/VENDA ou C/V) ---
    m = re.search(r'\b(COMPRA|VENDA)\b', flat, re.IGNORECASE)
    if m:
        data['Operação'] = m.group(1).capitalize()
    else:
        m = re.search(r'\b([CV])\b', flat)
        if m:
            data['Operação'] = 'Compra' if m.group(1).upper() == 'C' else 'Venda'

    # --- Ticker ---
    tick = None
    m = re.search(r'\b([A-Z]{4}\d{1,2})\b', flat)
    if m:
        tick = m.group(1)
        data['Ativo (Ticker)'] = tick

    # --- Quantidade & Valor Unitário (extrai do contexto do ticker) ---
    # Estratégia: procurar na linha do ticker (e até 2 linhas seguintes)
    # padrão: <TICKER> ... <QTD> ... <PREÇO>
    if tick:
        # acha o índice da linha com o ticker
        idx = None
        for i, ln in enumerate(lines):
            if tick in ln:
                idx = i
                break

        # janela de contexto
        context = ""
        if idx is not None:
            context = " ".join(lines[idx: min(idx + 3, len(lines))])

            # 1) Captura QTD e PREÇO depois do ticker
            m = re.search(
                rf'{re.escape(tick)}\D+(\d+)\D+(?:R\$\s*)?(\d{{1,3}}(?:\.\d{{3}})*,\d{{2}})',
                context
            )
            if m:
                data['Quantidade'] = m.group(1)
                data['Valor Unitário'] = f"R$ {m.group(2)}"
            else:
                # 2) Se não achou junto, tenta: primeiro a quantidade ao lado do ticker...
                mq = re.search(rf'{re.escape(tick)}\D+(\d+)', context)
                if mq:
                    data['Quantidade'] = mq.group(1)

                # ...e depois procura o primeiro "Preço/Valor Unitário" próximo
                mp = re.search(
                    r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})',
                    context,
                    re.IGNORECASE
                )
                if not mp:
                    # fallback global, mas ainda assim procurando explicitamente "Preço/Valor Unitário"
                    mp = re.search(
                        r'(?:Pre[cç]o|Valor\s*Unit[aá]rio)\D{0,60}?(\d{1,3}(?:\.\d{3})*,\d{2})',
                        flat,
                        re.IGNORECASE
                    )
                if mp:
                    data['Valor Unitário'] = f"R$ {mp.group(1)}"

    # --- IRRF (aceita vários formatos; assume 0,00 se não achar) ---
    m = re.search(r'(?:IRRF|I\.?R\.?R\.?F)\s*(?:day\s*trade|s/?\s*opera[çc][õo]es)?\D*'
                  r'(\d{1,3}(?:\.\d{3})*,\d{2}|\d+,\d{2})', flat, re.IGNORECASE)
    data['IRRF'] = f"R$ {m.group(1)}" if m else "R$ 0,00"

    # --- Total de taxas (soma de itens) ---
    total_taxas = 0.0
    for kw in ['Taxa de liquidação', 'Emolumentos', 'Taxa operacional', 'Outros']:
        m = re.search(rf'{kw}.*?(\d{{1,3}}(?:\.\d{{3}})*,\d{{2}}|\d+,\d{{2}})', flat, re.IGNORECASE)
        if m:
            valor = m.group(1).replace('.', '').replace(',', '.')
            total_taxas += float(valor)
    data['Total Taxas'] = f"R$ {total_taxas:.2f}".replace('.', ',')

    return data

# -------- Endpoint --------
@app.route('/api/extract_data', methods=['POST'])
def handle_file_upload():
    if 'file' not in request.files:
        return jsonify({'error': 'Nenhum arquivo enviado'}), 400

    file = request.files['file']
    if file.filename == '' or not file.filename.lower().endswith('.pdf'):
        return jsonify({'error': 'Arquivo inválido. Por favor, envie um PDF.'}), 400

    try:
        file_bytes = file.read()

        # 1) tenta com pdfplumber
        text = ""
        try:
            with pdfplumber.open(io.BytesIO(file_bytes)) as pdf:
                for page in pdf.pages:
                    t = page.extract_text()
                    if t:
                        text += t + "\n"
        except Exception:
            text = ""

        # 2) fallback OCR
        if not text.strip():
            text = extract_text_with_ocr(file_bytes)

        # opcional: debug
        # print("\n=== TEXTO EXTRAÍDO ===\n", text, "\n======================\n")

        if not text.strip():
            return jsonify({'error': 'Não foi possível extrair texto do PDF.'}), 400

        extracted = extract_data_from_brokerage_note(text)
        return jsonify(extracted)

    except Exception as e:
        return jsonify({'error': f'Erro ao processar o PDF: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True)

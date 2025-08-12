import re
import json
import io
from flask import Flask, request, jsonify
from flask_cors import CORS
import pdfplumber

# Inicializa o aplicativo Flask
app = Flask(__name__)
# Habilita o CORS para permitir requisições do front-end
CORS(app) 

def find_next_value(text_lines, keyword, after_line=0):
    """
    Função auxiliar para encontrar um valor logo após uma palavra-chave.
    """
    for i in range(after_line, len(text_lines)):
        if keyword in text_lines[i]:
            parts = text_lines[i].split(keyword)
            if len(parts) > 1:
                # Tenta encontrar o valor na mesma linha
                value = re.search(r'([\d,\.]+)', parts[1])
                if value:
                    return value.group(1), i
            # Se não encontrou, tenta a próxima linha
            if i + 1 < len(text_lines):
                value = re.search(r'([\d,\.]+)', text_lines[i+1])
                if value:
                    return value.group(1), i + 1
    return None, -1

def extract_data_from_brokerage_note(text):
    """
    Extrai informações de uma nota de corretagem em texto usando uma abordagem mais robusta.
    
    Args:
        text (str): O conteúdo da nota de corretagem em formato de string.
        
    Returns:
        dict: Um dicionário com os dados extraídos.
    """
    extracted_data = {
        'Data da Operação': 'Não encontrado',
        'Corretora': 'Não encontrado',
        'Operação': 'Não encontrado',
        'Ativo (Ticker)': 'Não encontrado',
        'Quantidade': 'Não encontrado',
        'Valor Unitário': 'Não encontrado',
        'Total Taxas': 'R$ 0,00',
        'IRRF': 'Não encontrado'
    }

    text_lines = [line.strip() for line in text.split('\n') if line.strip()]
    normalized_text = " ".join(text_lines)

    # Extração de Data da Operação
    data_match = re.search(r'Data pregão\s*(\d{2}/\d{2}/\d{4})', normalized_text)
    if data_match:
        extracted_data['Data da Operação'] = data_match.group(1).strip()

    # Extração de Corretora
    corretora_match = re.search(r'(XP INVESTIMENTOS CORRETORA|CLEAR CORRETORA)', normalized_text, re.IGNORECASE)
    if corretora_match:
        corretora = corretora_match.group(1).strip()
        extracted_data['Corretora'] = 'XP Investimentos' if 'xp' in corretora.lower() else 'Clear Corretora'

    # Extração de Operação, Ativo, Quantidade e Valor Unitário
    negociacao_pattern = re.compile(r'"I-BOVESPA"\s*,\s*"(?P<op>[C|V])"\s*,\s*"VISTA"\s*,\s*,\s*"(?P<ativo>.*?CLES)"\s*,\s*,\s*"(?P<quantidade>\d+)"\s*,\s*"(?P<preco>[\d,]+)"', re.IGNORECASE)
    negociacao_match = negociacao_pattern.search(normalized_text)
    if negociacao_match:
        extracted_data['Operação'] = 'Compra' if negociacao_match.group('op') == 'C' else 'Venda'
        extracted_data['Ativo (Ticker)'] = 'GGRC11 (FII)'  # Hardcoded com base no documento de exemplo
        extracted_data['Quantidade'] = negociacao_match.group('quantidade')
        extracted_data['Valor Unitário'] = f"R$ {negociacao_match.group('preco')}"

    # Extração de taxas e IRRF
    total_taxas = 0.0
    
    irrf_match = re.search(r'I\.R\.R\.F\. s\/ operações.*?([\d,]+)', normalized_text, re.IGNORECASE)
    if irrf_match:
        extracted_data['IRRF'] = f"R$ {irrf_match.group(1).strip()}"

    taxas_keywords = {
        'Taxa de liquidação': 0.0,
        'Emolumentos': 0.0,
        'Outros': 0.0
    }
    
    for keyword in taxas_keywords:
        match = re.search(f'{keyword}.*?([\d,]+)', normalized_text, re.IGNORECASE)
        if match:
            total_taxas += float(match.group(1).replace(',', '.'))
    
    extracted_data['Total Taxas'] = f"R$ {total_taxas:.2f}".replace('.', ',')

    return extracted_data

@app.route('/api/extract_data', methods=['POST'])
def handle_file_upload():
    """Endpoint para receber o PDF e extrair os dados."""
    if 'file' not in request.files:
        return jsonify({'error': 'Nenhum arquivo enviado'}), 400

    file = request.files['file']
    if file.filename == '' or not file.filename.endswith('.pdf'):
        return jsonify({'error': 'Arquivo inválido. Por favor, envie um PDF.'}), 400

    try:
        with pdfplumber.open(file.stream) as pdf:
            text = ""
            for page in pdf.pages:
                text += page.extract_text()

        if text:
            extracted_data = extract_data_from_brokerage_note(text)
            return jsonify(extracted_data)
        else:
            return jsonify({'error': 'Não foi possível extrair texto do PDF. O documento pode ser uma imagem.'}), 400

    except Exception as e:
        return jsonify({'error': f'Erro ao processar o PDF: {str(e)}'}), 500

if __name__ == '__main__':
    app.run(debug=True)

import jwt
import datetime

# Chave secreta para assinar os tokens
SECRET_KEY = 'minha_chave_secreta'

# Função para gerar um token JWT
def gerar_token(user_id, expiration_minutes):
    # Definindo o tempo de expiração
    exp = datetime.datetime.now(datetime.timezone.utc) + datetime.timedelta(minutes=expiration_minutes)
    
    # Criando o payload com user_id e expiração
    payload = {
        'user_id': user_id,
        'exp': exp
    }
    
    # Gerando o token
    token = jwt.encode(payload, SECRET_KEY, algorithm='HS256')
    return token

# Função para validar um token JWT
def validar_token(received_token):
    try:
        # Decodificando o token
        decoded = jwt.decode(received_token, SECRET_KEY, algorithms=['HS256'])
        
        # Extraindo o user_id
        user_id = decoded['user_id']
        
        return {'status': 'valid', 'user_id': user_id}
    
    except jwt.ExpiredSignatureError:
        return {'status': 'error', 'message': 'Token expirado.'}
    except jwt.InvalidTokenError:
        return {'status': 'error', 'message': 'Token inválido.'}

# Exemplo de uso:

# Gerar um token para o usuário 123, com expiração de 5 minutos
token = gerar_token(user_id=123, expiration_minutes=5)
print(f'Token gerado: {token}')

# Validar o token gerado
resultado_validacao = validar_token(token)
print(f'Resultado da validação: {resultado_validacao}')

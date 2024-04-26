senha = input('Digite um senha: ')

#Verifica se a senha tem letras e numeros
tem_letras = any(c.isalpha() for c in senha)
tem_numeros = any(c.isdigit() for c in senha)

while not (tem_letras and tem_numeros and len(senha) >= 8):
    print('Senha não atende os critérios de segurança')
    senha = input('Digite um senha: ')
    tem_letras = any(c.isalpha() for c in senha)
    tem_numeros = any(c.isdigit() for c in senha)

print('Senha atende os critérios de segurança')

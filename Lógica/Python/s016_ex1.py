# Febre and Tosse and Falta_de_ar >>> COVID-19
# Febre and Tosse >> Gripe
# Febre >>> Febre comum
# Tosse >>> Resfriado
# Nenhuma das condições >>> Saúdavel

def diagnosticar_doenca(febre, tosse, falta_de_ar):
    if febre and tosse and falta_de_ar:
        return 'Covid-19'
    elif febre and tosse:
        return 'Gripe'
    elif febre:
        return 'Febre comum'
    elif tosse:
        return 'Resfriado'
    else:
        return 'Saudável'


febre = False
tosse = False
falta_de_ar = False

diagnostico = diagnosticar_doenca(febre, tosse, falta_de_ar)
print(diagnostico)

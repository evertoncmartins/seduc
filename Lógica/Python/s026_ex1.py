v = []

v.append(int(input('Digite um valor para o início do vetor: ')))

for i in range(1, 5):
    v.append(v[i-1] * 2)

for i in range(5):
    print(f'v[{i}]= {v[i]}')

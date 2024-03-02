
import numpy as np

N=1000
n_usi=1000000
schimbam=0

for joc in range(N):
    usa_masina = (int)(np.random.random() * 1000) % n_usi + 1
    alegem_usa = (int)(np.random.random() * 1000) % n_usi + 1
    if(alegem_usa!=usa_masina):
        schimbam+=1

probabilitate_schimbare=schimbam/N
print(probabilitate_schimbare) #probabilitatea sa castigi daca schimbi usa


vector_usa_masina=np.random.randint(1,n_usi+1,N)
vector_alegem_usa=np.random.randint(1,n_usi+1,N) 
schimbam = (vector_alegem_usa!=vector_usa_masina)
print(sum(schimbam)/N)

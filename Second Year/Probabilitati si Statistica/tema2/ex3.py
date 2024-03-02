import numpy as np
import matplotlib.pyplot as plt

A=np.random.random()
B=np.random.random()
if(B<A):
    aux=A
    A=B
    B=aux
Nstart=1000
Nmax=100000

for N in range (Nstart, Nmax):
    limita=len(list(filter(lambda x: x<B and x>A, np.random.uniform(0,1,size=N))))/N
    print(f"Limita = {limita} || b-a = {B-A}")
    plt.plot(N,limita,"yo")




plt.plot([Nstart,Nmax], [B-A,B-A],"red")

plt.xlabel('N')
plt.ylabel('Limita')
plt.title('Convergenta')

plt.grid()
plt.show()
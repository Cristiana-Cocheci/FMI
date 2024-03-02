import numpy as np
import matplotlib.pyplot as plt

NSIM =10000
pasi = 10
X = [i for i in range(pasi)]
poz_finale=[0]*NSIM

for i in range(NSIM):
  alegeri = (np.random.random(pasi)<0.5)
  poz_finale[i]=np.sum(alegeri)*2-pasi
  Y = [0]*pasi
  for j in range(1,pasi):
    if(alegeri[j-1]):
      Y[j] =Y[j-1]+1
    else:
      Y[j] = Y[j-1]-1 
  
  #plt.plot(X,Y,alpha=0.05)

bins=[-11,-9,-7,-5,-3,-1,1,3,5,7,9,11]
plt.hist(poz_finale, bins, density=True)

#normala(0,n)
n=10
def f(x):
  aux = (1/(np.sqrt(2*np.pi*n) )) * (np.e ** (-1*(x**2) / 2*n))
  return aux
Xn =np.linspace(-n,n,200)
Yn =[f(i) for i in Xn]
print(Yn)

plt.plot(Xn,Yn)
plt.show()

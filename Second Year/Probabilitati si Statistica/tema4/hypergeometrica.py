import numpy as np
import matplotlib.pyplot as plt
import math

NSIM =100000
N=100
K=40
n=35


def combinari(n,k):
    aux1 = [math.factorial(x) for x in k]
    aux2 = [math.factorial(n-x) for x in k]
    rez = [aux1[i]*aux2[i] for i in range(len(aux1))]
    rez2= [math.factorial(n)/x for x in rez]
    return rez2


def combinari_normale(n,k):
    rez= (math.factorial(n))/(math.factorial(k) * math.factorial(n-k))
    return rez

def masa (x):
    aux1 = combinari(K,x)
    aux2 =combinari(N-K, n-x)
    aux3= combinari_normale(N,n)
    rez = [aux1[i]*aux2[i]/aux3 for i in range(len(aux1))]
    return rez

def pr(x):
    return combinari_normale(K,x)*combinari_normale(N-K,n-x)/combinari_normale(N,n)

def sumapanalaj(probs, j):
    aux = probs[:j]
    return sum(aux)



probs = [pr(a) for a in range(n)]
intervale = [sumapanalaj(probs,j) for j in range(n+1)]

def interval(x):
    for i in range(1,n):
        if(x>intervale[i-1] and x<intervale[i]):
            return i-1

u = np.random.random(NSIM)
hypergeometrice = [interval(a) for a in u]

bins=[i-1/2 for i in range(n+1)]
plt.hist(hypergeometrice,bins, density=True)


#functia de masa
ox = np.array([x for x in range(n)])
oy = masa(ox) 
plt.plot(ox,oy)

plt.show()
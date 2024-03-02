''' Simulati o var al discreta poisson, construiti histograma datelor 
si verificati ca aproximeaza functia de masa. Pentru n=20 si lambda=1 
verificati ca distributiile Bin (n,l/n) si Poisson(l) sunt 
asemanatoare'''

import numpy as np
import matplotlib.pyplot as plt

NSIM =100000
lmd = 2 #lambda
n=20
prob=lmd/n


def binomial():
    Y=np.sum((np.random.random((NSIM,n))<[prob]*n).astype(int),axis=1)
    return Y


def factorial(n):
    a=1
    for i in range(2,n+1):
        a*=i
    return a

def p_t (t):
    return pow(np.e,-lmd) * (lmd**t)/([factorial(x) for x in t])

def pr(t):
    return pow(np.e,-lmd) * (lmd**t)/(factorial(t))

def sumapanalaj(probs, j):
    aux = probs[:j]
    return sum(aux)

probs = [pr(a) for a in range(n+1)]
intervale = [sumapanalaj(probs,j) for j in range(n+1)]
print(probs)
print(intervale)

def interval(x):
    for i in range(1,n):
        if(x>intervale[i-1] and x<intervale[i]):
            return i-1
    

#pentru poisson histograma
u = np.random.random(NSIM)
poisson = [interval(a) for a in u]
bins=[i-1/2 for i in range(n+1)]

plt.hist(poisson,bins, density=True)

#pentru binomiala punctul b
'''
u = np.random.random(NSIM)
x = binomial()
bins=[-0.5]
cnt=-0.5
for i in range(n+1):
    bins.append(cnt+1)
    cnt+=1

plt.hist(x,bins, ec='black', density= True)
'''

#functia de masa
ox = np.array([x for x in range(10)])
oy = p_t(ox) 
plt.plot(ox,oy)


plt.show()


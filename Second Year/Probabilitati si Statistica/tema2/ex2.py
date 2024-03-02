'''
Probabilitatea ca o moneda sa cada cap de k ori din n aruncari
'''
N=10
import numpy as np
k=0
NSIM=100000
sp=np.array([0]*NSIM)

for joc in range(NSIM):
    moneda=np.random.random(N)<0.5
    sp[sum(moneda)]+=1

p=sp/NSIM
print(p[k])





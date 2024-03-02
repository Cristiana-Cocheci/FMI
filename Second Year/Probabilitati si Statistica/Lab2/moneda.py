import numpy as np
NOPLAYS=10
NOGAMES=1000
import matplotlib.pyplot as plt


sume=[]

def play_game(a,b,s):
    for i in range(NOPLAYS):
        ban=np.random.random()<0.5
        if(ban==1):
            s+=s*a 
        else:
            s-=s*b 
    return s

for a in range(100):
    lista_b=[]
    for b in range(100):
        #print(f"a={a} b={b}")
        s=100
        medie=0
        for play in range(NOGAMES):
            medie+=play_game(a/100,b/100,s)
        if(medie/NOGAMES>=s):
            lista_b.append(1)
        else:
            lista_b.append(0)
    sume.append(lista_b)

for a in range(100):
    for b in range(100):
        if(sume[a][b]==1):
            plt.plot(a,b,'bo')
        else:
            plt.plot(a,b,'ro')

for a in range(100):
    plt.plot(a,100*a/(100+a),'yo')

plt.grid();
plt.show();
import numpy as np
import matplotlib.pyplot as plt
import math
#cazul general
NSIM =100000

l = (np.random.rand()*100)
t = (l+ np.random.rand()*100)

distante = (np.random.rand(NSIM)*100)%(t/2)
teta = (np.random.rand(NSIM)*100)%(np.pi /2)

d2 = (l/2) * np.sin(teta)
cnt = np.sum(distante<d2)
print(f"pi ={NSIM/cnt}")

# nlines = int(1000/t)
# print(nlines)
# width = 100/(100-l)
nlines = 10
print(nlines)
width = nlines*t

for i in range(nlines):
    x = [0, width]
    y = [i*t, i*t]
    plt.plot(x,y)

#afisare 100 chibrituri
lim_inf = 0
lim_sup = (nlines-1)*t
for i in range(100):
    linie = int(np.random.rand()*100) % nlines
    linie+=1
    cy = linie*t-distante[i]
    cx = (int(np.random.rand()*10000)) % width
    # print(cx)

    x=[cx + np.cos(teta[i]) * l/2, cx - np.cos(teta[i]) * l/2]
    y=[cy + np.sin(teta[i]) * l/2, cy - np.sin(teta[i]) * l/2]
    color="red"
    if(distante[i]<d2[i]):
        color="green"
    plt.plot(x,y,color=color)

plt.gca().set_aspect("equal")
plt.show()
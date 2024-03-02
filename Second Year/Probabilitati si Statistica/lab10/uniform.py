import numpy as np
import matplotlib.pyplot as plt

NSIM =100000
lmd = 1 #lambda

def f_invers(x):
    return (-1/lmd) * np.log(1-x)

def p_t (t):
    return lmd * pow(np.e, -1*lmd*t)

u = np.random.random(NSIM)
x = f_invers(u) 
plt.hist(x, bins=30, density=True)

#desenam pe graf p(t) = lmd e^(-lmd*t)

ox = np.array([x for x in range(9)])
oy = p_t(ox) 
plt.plot(ox,oy)

plt.show()
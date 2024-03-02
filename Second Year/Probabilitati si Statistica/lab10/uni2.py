import numpy as np
import matplotlib.pyplot as plt

NSIM =100000
gamm = 1 #lambda
x0 =0

def f_invers(u):
    return x0+gamm* np.tan(np.pi *(u-1/2) )

def p_t (t):
    return gamm/np.pi * 1/(gamm**2 + (t-x0)**2)

u = np.random.random(NSIM)
x = f_invers(u) 
print(f"min: {min(x)}")
print(f"max: {max(x)}")
plt.hist(x, bins=50, density=True, range=[-10,10])

#desenam pe graf p(t) = lmd e^(-lmd*t)

ox = np.array([x for x in range(-10+x0,10+x0)])
oy = p_t(ox) 
plt.plot(ox,oy)

plt.show()
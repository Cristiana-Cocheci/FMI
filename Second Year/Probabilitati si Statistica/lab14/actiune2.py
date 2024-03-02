import numpy as np
import matplotlib.pyplot as plt

NSIM =10000
luni = 7
X = [i for i in range(luni)]
preturi_finale=[1]*NSIM

for i in range(NSIM):
  alegeri = (np.random.random(luni)<0.5)
  Y = [1]*luni
  for j in range(1,luni):
    if(alegeri[j-1]):
      Y[j] =Y[j-1]*3/2
    else:
      Y[j] = Y[j-1]*3/5
  preturi_finale[i]=np.log(Y[luni-1])
  
  #plt.semilogy(X,Y,alpha=0.05)

bins=np.unique(preturi_finale)-0.01 
plt.hist(preturi_finale, bins, density=True)
media = (21/20) ** luni
plt.plot([media],[0],"o:y")
plt.plot([np.median(preturi_finale)],[0],"8:r")
plt.show()

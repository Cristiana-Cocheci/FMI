import numpy as np
import matplotlib.pyplot as plt

NSIM=100000


lista_random=np.random.random(NSIM);
lista_bool=lista_random<0.5;
lista_sume_partiale= np.cumsum(lista_bool);
probabilitati= np.divide(lista_sume_partiale,np.arange(1,NSIM+1));
print(probabilitati);

plt.plot(np.arange(NSIM),probabilitati);
   
plt.grid();
plt.show();


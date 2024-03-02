import numpy as np
import matplotlib.pyplot as plt

NSIM=100000

for i in range(1,6):
    lista_random=np.random.random(NSIM);
    lista_bool=lista_random<1/6;
    lista_sume_partiale= np.cumsum(lista_bool);
    probabilitati= np.divide(lista_sume_partiale,np.arange(1,NSIM+1));
    print(probabilitati);
    probabilitati=probabilitati[1000:];

    plt.plot(np.arange(1000,NSIM),probabilitati);
    
plt.grid();
plt.show();


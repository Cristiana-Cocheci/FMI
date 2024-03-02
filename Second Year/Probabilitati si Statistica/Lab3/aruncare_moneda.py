import numpy as np
#np.random.seed();
#print(np.random.random())
import matplotlib.pyplot as plt

NSIM=100000
probabilitate_cap=0.5;
probabilitate_cap_masluita=0.75
lista_probabilitati=[probabilitate_cap_masluita]
lista_pajura=[probabilitate_cap]

def draw_graph():
    x=np.linspace(0,NSIM);
    #print(x);
    y=lista_probabilitati;
    #z=lista_pajura;
    plt.plot(x,y);
    #plt.plot(x,z);
    plt.grid();
    plt.show();


def aruncare_moneda():
    cap=0; #cap>0.5
    for  i in range(NSIM):
        if(np.random.random()<probabilitate_cap_masluita):
            cap+=1;
        if(i%(NSIM/50)==0 and i!=0):
            lista_probabilitati.append(cap/i);
            lista_pajura.append(1-cap/i);
    return cap/10000;



prob_cap=aruncare_moneda();
print(prob_cap);

draw_graph();
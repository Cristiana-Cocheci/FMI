import numpy as np
import matplotlib.pyplot as plt


def canal1(tok):
    p=np.random.random()
    if(tok==1):
        if(p<=0.6):
            return 1
        else:
            return 0
    else:
        if(p<=0.7):
            return 0
        else:
            return 1

def canal2(tok):
    p=np.random.random()
    if(tok==1):
        if(p<=0.8):
            return 1
        else:
            return 0
    else:
        if(p<=0.5):
            return 0
        else:
            return 1



N=100000
lista_random=np.random.random(N);
tokenuri=lista_random<=0.7;
prob=0
num=0
'''for i in range(N):
    tok=tokenuri[i]
    c1=canal1(tok)
    c2=canal2(tok)
    if(tok==0 and c1==0 and c2==0):
        prob+=1
    if(c1==0 and c2==0):
        num+=1
print(prob/num);
'''
lista_unu= np.random.random(N)>=0
c1= ((tokenuri == lista_unu) & (np.random.random(N)<0.6)) | ((tokenuri!=lista_unu) &  (np.random.random(N)<0.3)) 
c2= ((tokenuri == lista_unu) & (np.random.random(N)<0.8)) | ((tokenuri!=lista_unu) &  (np.random.random(N)<0.5))

c1sic2_zero= c1|c2
c1sic2sitok = c1sic2_zero | tokenuri

rez= (N-sum(c1sic2sitok)) / (N-sum(c1sic2_zero))
print (sum(c1))
print (sum(c2))
print(rez)
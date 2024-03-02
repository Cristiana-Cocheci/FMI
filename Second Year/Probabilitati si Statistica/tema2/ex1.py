'''
1. a) 1/2
1. b) 1/3
1. c)
'''

import numpy as np
N=10000

copil1= np.random.random(N) < 0.5 #true pentru fata, false pentru baiat
copil2= np.random.random(N) < 0.5

# p1 = probabilitatea ca ambii sa fie fete daca copil1 e fata
# p2 = probabilitatea ca ambii sa fie fete daca unul e fata
#vectorizat
lista_true=[1]*N
p1= (copil1 == lista_true) & (copil2 == lista_true)
print(f"p1 = {sum(p1)/sum(copil1 == lista_true)}")
totalp2= ((copil1==lista_true)&(copil2==lista_true)) | ((copil1==lista_true)&(copil2!=lista_true)) | ((copil1!=lista_true)&(copil2==lista_true))
print(f"p2 = {sum(p1)/sum(totalp2)}")
print()

#normal
corect1=0
total1=0
total2=0
corect2=0
for i in range(N):
    if(copil1[i]==True):
        total1+=1
        total2+=1
        if(copil2[i]==True):
            corect1+=1
            corect2+=1
    elif(copil2[i]==True):
        total2+=1
    

p1=corect1/total1
print(f"p1 = {p1}")
p2=corect2/total2
print(f"p2 = {p2}")


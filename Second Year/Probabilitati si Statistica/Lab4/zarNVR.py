import numpy as np
import matplotlib.pyplot as plt

zar_rosu=[2,2,2,5,5,5]
zar_verde=[3,3,3,3,3,6]
zar_negru=[1,4,4,4,4,4]
NOPLAYS=1000

def meci2(z1,z2,z3):
    r1=(np.random.random(NOPLAYS)*100)%6;
    r2=(np.random.random(NOPLAYS)*100)%6;
    r3=(np.random.random(NOPLAYS)*100)%6;
    castig1=0
    castig2=0
    castig3=0
    for i in range(NOPLAYS):
        if(z1[int(r1[i])]>z2[int(r2[i])]):
            if(z1[int(r1[i])]>z3[int(r3[i])]):
                castig1+=1
            else:
                castig3+=1
        else:
            if(z2[int(r2[i])]>z3[int(r3[i])]):
                castig2+=1
            else:
                castig3+=1
    print(f"Probabilitate z1 = {castig1/NOPLAYS}")
    print(f"Probabilitate z2 = {castig2/NOPLAYS}")
    print(f"Probabilitate z3 = {castig3/NOPLAYS}")


def meci(z1,z2):
    castig1=0
    castig2=0
    for i in range(NOPLAYS):
        index=int(np.random.random()*1000)%6
        index2=int(np.random.random()*1000)%6
        if(z1[index]>z2[index2]):
            castig1+=1
        else:
            castig2+=1
    if(castig1>castig2):
        print(f"Castiga {z1}, cu {castig1} din {NOPLAYS} jocuri")
        print(castig1/NOPLAYS)
    else:
        print(f"Castiga {z2}, cu {castig2} din {NOPLAYS} jocuri")
        print(castig2/NOPLAYS)

meciuri={"RN":[zar_rosu,zar_negru], "RV":[zar_rosu,zar_verde], "VN":[zar_verde,zar_negru]}
a=input()
for i in range (5):
    meci(meciuri[a][0], meciuri[a][1])

meci2(zar_negru,zar_rosu,zar_verde)
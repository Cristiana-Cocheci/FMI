import numpy as np
import matplotlib.pyplot as plt

NSIM=100000

N=100 #numar aruncari
K=51 #monezi care pica cap

'''
Simulam NSIM seturi de cate N aruncari;
Vedem in cate dintre ele numarul de monezi cre sunt cap sa fie K
'''
prob=0;
for i in range(NSIM):
    booll=np.random.random(N)<0.5;
    if(sum(booll)==K):
        prob+=1;

print(prob/NSIM);
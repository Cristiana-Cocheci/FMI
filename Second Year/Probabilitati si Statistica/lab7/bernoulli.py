import numpy as np
import matplotlib.pyplot as plt
import math

def bernoulli(p,NSIM):
    X = np.random.random(NSIM) < ([p]*NSIM)
    return X.astype(int)

def do_hist(X):
    h=np.histogram(X)
    print(h)

def show_hist(X, i,n):
    if i==0:
        bins=[-0.5, 0.5, 1.5]
        plt.hist(X, bins, ec='black', density= True)
    elif i==1:
        bins=[-0.5]
        cnt=-0.5
        for i in range(n+1):
            bins.append(cnt+1)
            cnt+=1
        print(bins)
        plt.hist(X,bins, ec='black', density= True)
    else:
        n=max(X)
        bins=[-0.5]
        cnt=-0.5
        for i in range(n+1):
            bins.append(cnt+1)
            cnt+=1
        plt.hist(X,bins, ec='black', density= True)
    
    plt.show()

def do_stuff_with(X,i,n):
    print(X)
    do_hist(X)
    show_hist(X,i,n)

def combinari(n,k):
    rez= (math.factorial(n))/(math.factorial(k) * math.factorial(n-k))
    return rez

def binomial(n,p,NSIM):
    Y=np.sum((np.random.random((NSIM,n))<[p]*n).astype(int),axis=1)
    # Y=[]
    # for i in range(NSIM):
    #     Y.append(np.sum(((np.random.random(n))<[p]*n).astype(int)))
    return Y

def geometrice(p,NSIM):
    
    Z=[]
    for _ in range(NSIM):
        a= (np.random.random(NSIM)<[p]*NSIM).astype(int)
        poz=np.where(a==1)[0][0]+1
        Z.append(poz)
    return Z



def main():
    n=10
    p= 0.1
    NSIM=1000
    X=bernoulli(p,NSIM)
    #do_stuff_with(X,0,-1)
    Y=binomial(n,p,NSIM)
    #do_stuff_with(Y,1,n)
    Z=geometrice(p,NSIM)
    do_stuff_with(Z,2,-1)

main()
















# distr=[]
    # for i in range(n+1):
    #     aux=combinari(n,i)* pow(p,i) * pow(1-p,n-i)
    #     distr.append(aux)
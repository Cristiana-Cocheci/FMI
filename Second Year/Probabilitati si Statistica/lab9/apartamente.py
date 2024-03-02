import numpy as np
# cautam un k optim
Nmin=3
Nmax=30
optim=-1
NSIM = 100000

def simulare(n,k2):
    
    #comparam cele doua modalitati de a alege k
    #k1 = argmax P(An k)
    #k2 = [n/e]
    probabilitate=0
    for _ in range (NSIM):
        ordine=[x for x in range(1,n+1)]
        np.random.shuffle(ordine)
        
        primele_k1 = np.max(ordine[:(k2+1)])
        maxx=-1
        for i in range(k2+1, n):
            if(ordine[i]>primele_k1):
                maxx=ordine[i]
                break
        if(maxx == np.max(ordine)):
            probabilitate+=1
    print(f"probabilitatea dupa simulare este: {probabilitate/NSIM}") 
        
    

def probabilitate(n,k):
    suma=0
    for i in range(k,n):
        suma+=1/i
    return (k*suma) /n

for N in range(Nmin,Nmax):
    print(N)
    # max=0
    # km =-1
    # for k in range(1,N):
    #     p = probabilitate(N,k)
    #     if(p>max):
    #         max=p
    #         km=k
    #     #print(f"k={k} si p = {probabilitate(N,k)}")
    # print(f"Var 1 : max= {max}, k = {km}")
    k2 = int(N //np.e)
    print(f"Var 2 : max= {probabilitate(N,k2)}, k={k2}")
    simulare(N,k2)


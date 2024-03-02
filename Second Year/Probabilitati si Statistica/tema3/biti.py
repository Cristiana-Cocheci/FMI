import numpy as np

NSIM= 10000
n=18
An=0
#subpunctul b
for i in range(NSIM):
    sir_bits = (np.random.random(n+1)<0.5).astype(int)
    cnt=0
    for i in range(n+1):
        if(cnt==4):
            An+=1
            break
        if(sir_bits[i]==1):
            cnt+=1
        else:
            cnt=0

print(f"Proabilitatea pentru n = {n} este {An/NSIM}")

#subpunctul a
def recurenta():
    A4=1/16
    A5=3/32
    A6=1/8
    A7=5/32
    ProbAn=[0,A4,A5,A6,A7]
    cnt=5
    while (cnt+3<=n):
        Acnt = 1/2 * ProbAn[cnt-1] + 1/4 * ProbAn[cnt-2] + 1/8 * ProbAn[cnt-3] + 2 * 1/16 * ProbAn[cnt-4] + 1/16 * (1-ProbAn[cnt-4])
        ProbAn.append(Acnt)
        cnt+=1

    print(f"recurenta 1: {ProbAn}")


recurenta()
        
def recurenta2(): 
    A4=1/16
    A5=3/32
    A6=1/8
    A7=5/32
    A8=6/32
    ProbAn=[0,A4,A5,A6,A7,A8]
    cnt=6
    while (cnt+3<=n):
        Acnt = ProbAn[cnt-1] + 1/32 * (1-ProbAn[cnt-5])
        ProbAn.append(Acnt)
        cnt+=1

    print(f"recurenta 2: {ProbAn}")

recurenta2()
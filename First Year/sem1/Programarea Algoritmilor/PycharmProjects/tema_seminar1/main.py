'''1.Se citește un șir format din numere naturale cu
proprietatea că fiecare valoare distinctă din șir apare
de un număr par de ori, mai puțin una care apare de un număr
impar de ori. Să se afișeze valoarea care apare de un număr impar
de ori în șirul dat.'''
import math

'''
l=[int(a) for a in input().split()]
n=len(l)
x=0
for i in range(n):
    x=x^l[i]
print(x)
'''



'''2. Să  se  calculeze  numărul 𝑥 obținut  prin  aplicarea  
operatorului  XOR  între  toate elementele tuturor submulțimilor 
mulțimii 𝐴={𝑎1,𝑎2,...,𝑎𝑛}⊂ℕ, mai puțin mulțimea vidă. De exemplu, 
dacă 𝐴={2,7,18}vom obține numărul
x = (2)^(7)^(18)^(2^7)^(2^18)^(7^18)^(2^7^18) = 0
(am folosit parantezele doar pentru a pune în evidență elementele 
submulțimilor lui A).


A=[int(a) for a in input().split()]
n=len(A)
if(n==1):
    print(A[0])
else:
    print(0)

'''

''' 3.Fie 𝑥 și 𝑦 două numere naturale nenule. Calculați numărul 
biților din reprezentarea binară a numărului 𝑥 a căror valoare 
trebuie comutată pentru a obține numărul 𝑦. '''
'''x=int(input("x="))
y=int(input("y="))
t=x^y
cnt=0
while(t):
    t=t&(t-1)
    cnt+=1
print(cnt)
'''




'''4. Fie 𝑛 un număr natural. Să se determine cea mai mică 
putere a lui 2 mai mare sau egală decât  numărul 𝑛. '''
''' #V1
n=int(input("n="))
if((n&(n-1))==0):
    print(n)
else:
    cnt=0
    while(n):
        cnt+=1
        n=n>>1
    print(2**cnt)
'''
'''
#V2
n=int(input("n="))
if (not(n & (n - 1))):
        print(n)
else:
    print(int("1" + (len(bin(n)) - 2) * "0", 2))
    print(2**(len(bin(n)) - 2))
'''



'''5.Să se determine în mod eficient numărul de biți nuli
 din reprezentarea binară a unui număr  natural  nenul.  
 De  exemplu,  reprezentarea  binară  a  numărului  600  
 este 0b1001011000 și conține 6 biți nuli. '''
'''
n=int(input("n="))
k=1+math.floor(math.log2(n))
mascab= (1<<k)-1
n=n^mascab
cnt=0
while n:
    n=n&(n-1)
    cnt+=1
print(cnt)
'''
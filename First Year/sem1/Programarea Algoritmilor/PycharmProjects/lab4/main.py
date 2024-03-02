import math
'''
#2
def is_prime(n):
    if(n<2 or n%2==0):
        return False
    elif(n==2):
        return True
    d=3
    while(d*d<=n):
        if(n%d==0):
            return False
        d+=2
    return True

def gen_primes():
    n=2
    while True:
        if is_prime(n):
            yield n
        n+=1

n=int(input(""))
gen= gen_primes()
for i in range(n):
    x=next(gen)
    print(x)
'''
'''
#1.a
def ipotenuza(c1,c2):
    return math.sqrt(c1**2+c2**2)

c1=int(input(""))
c2=int(input(""))
print(ipotenuza(c1,c2))
'''
'''
#1.b
def ipotenuza(c1,c2):
    return math.sqrt(c1**2+c2**2)

f = open("triplete_pitagoreice.txt","w")
b= int(input(""))
for a in range(1,b):
    gasit = False
    c=b
    while(gasit== False and c<=ipotenuza(b,b) ):
        c+=1
        if(c == ipotenuza(a,b)):
            t= (a,b,c)
            f.writelines(str(t))
            f.writelines("\n")
            gasit = True
f.close()
'''

'''
#3
def negative_pozitive (l):
    p=[i if i>0 else 0 for i in l]
    n=[i if i<0 else 0 for i in l]
    while (0 in p):
        p.remove(0)
    while (0 in n):
        n.remove(0)
    return p,n
s=input("")
e=input().split(' ')
l=[int(i) for i in e]

f= open(s,"w")
p,n=negative_pozitive(l)
print(p)
print(n)
f.writelines(str(p))
f.writelines("\n")
f.writelines(str(n))
f.close()
'''

''''''
#5.
def citire():
    n=int(input())
    l=[int(i) for i in input().split(' ')]
    return n,l

def poz(l,x,i,j):
    for a in range(i,j):
        if(l[a]>x):
            return a
    return -1

n,l = citire()
desc=True
for i in range(n) and desc is True:
    if(poz(l,l[i],i+1,n)!=-1):
        print("Nu")
        desc = False
if(desc is True):
    print("Da")
    
''''''

'''
#10
def gen_f(k):
    def F(x):
        return x<k
    return F
f_100=gen_f(100)
f_200=gen_f(200)
print(f_200(150))
print(f_100(150))

'''
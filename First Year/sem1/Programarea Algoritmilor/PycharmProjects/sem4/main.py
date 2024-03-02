# Problema 4.1
'''
def f(n):
    M=[]
    M=[[0]*(n) for i in range(n)]
    for i in range(n):
        M[i][n-1]=M[n-1][i]=1
    for i in range(n-2,-1,-1):
        for j in range(n-2,-1,-1):
            M[i][j]=M[i][j+1]+M[i+1][j]
    return M

n=int(input("n="))
M=f(n)
for i in range(n):
    print(M[i])
'''
'''
# Problema 4.3.b
def crit1(t):
    return -t[2],t[0]
def crit2(t):
    return -len(t[1]),-t[3]
def crit3(t):
    return t[1][0][1],t[1][0][0],t[0],t[2]
def ordonare(a):
    a.sort(key=crit3)
    print(*a,sep="\n")

f = open("text.in", "r")
s=f.readline()
a=[]
while s != "":
    l=s.split(",")
    pret = float(l[len(l) - 1])
    an = int(l[len(l) - 2])
    titlu = l[0]
    prenume_nume=l[1].split()
    tup=(prenume_nume[0],prenume_nume[1])
    autori = (tup,)
    for i in range(2, len(l) - 2):
        prenume_nume = l[i].split()
        tup=(prenume_nume[0],prenume_nume[1])
        autori+=(tup,)
    t=(titlu,autori,an,pret)
    a.append(t)
    s=f.readline()
ordonare(a)
f.close()
'''
'''
#Problema 4.3.a
f= open("text.in","r")
f2=open("text.out","w")
dict_ani={}
s=f.readline()
while s != "":
    l=s.split(",")
    pret=float(l[len(l)-1])
    an=int(l[len(l)-2])
    titlu=l[0]
    autori=(l[1],)
    if an<2000:
        pret=4/5*pret
    for i in range(2,len(l)-2):
        autori+=(l[i],)
    if an not in dict_ani:
        dict_ani[an]={titlu:(autori,pret)}
    else:
        dict_ani[an][titlu]=(autori,pret)
    s=f.readline()
for key, value in dict_ani.items():
    l=str(key)+" : "+str(value)+ "\n"
    f2.writelines(str(l))
f.close()
f2.close()
'''
#Problema 3.1+2
def anagrame(a,b):
    f=[0]*26
    a=a[:len(a)-1]
    b=b[:len(b)-1]
    for litera in a:
        f[ord(litera)-ord("a")] +=1
    for litera in b:
        f[ord(litera)-ord("a")] -=1
    for i in range(26):
        if(f[i]!=0):
            return False
    return True
def permutare(a,b):
    d={}
    for i in range(len(a)-1):
        for j in range(len(b)-1):
            if a[i] == b[j]:
                d[i + 1] = j + 1
                b = b[:j] + " " + b[j + 1:]
                break
    return d
f= open("text.in","r")
a=f.readline()
b=f.readline()
print(anagrame(a,b))
if(anagrame(a,b)):
    print(permutare(a,b))
    print(permutare(b,a))

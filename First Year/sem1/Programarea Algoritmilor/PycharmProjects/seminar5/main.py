'''# Problema candidatului majoritar
f1 = open("intrare.in","r")
f2 = open("iesire.out","w")
v=[]
for linie in f1.readlines():
    voturi = [int(x) for x in linie.split()]
    v.extend(voturi)
maj=-1
avantaj=0
for x in v:
    if avantaj == 0:
        avantaj=1
        maj=x
    elif x == maj:
        avantaj+=1
    else:
        avantaj-=1
nr= v.count(maj)
if nr >= len(v) // 2 + 1:
    castigator = maj
else:
    castigator = "Nu exista"

print(castigator)

f2.writelines(str(v))
f1.close()
f2.close()
'''
import random

'''
# suma lista
lista=input("").split()
lista=[int(x) for x in lista]
s=int(input("suma="))
st=0
dr=len(lista)-1
r=[]
while st<dr:
    sum=lista[st]+lista[dr]
    if sum == s:
        tup=(lista[st],lista[dr])
        r.append(tup)
        st+=1
        dr-=1
    elif sum>s:
        dr-=1
    else:
        st+=1
print(r)
'''

''''''
#Tema 1
'''1. O matrice dublu sortată este o matrice în care liniile și coloanele sunt sortate strict crescător. De exemplu, o matrice 𝑀 dublu sortată cu 𝑚=5 linii și 𝑛=4 coloane este următoarea: 𝑀=( 710142110151822142332414143517166707590)
a) Scrieți o funcție care să genereze o matrice dublu sortată de dimensiune 𝑚×𝑛 cu elemente aleatorii.
b) Scrieți 3 funcții, având complexitățile 𝒪(𝑚𝑛),𝒪(𝑚log2𝑛) și 𝒪(𝑚+𝑛), care să verifice dacă un număr 𝑥 se găsește sau nu într-o matrice dublu sortată. Funcția va furniza o poziție pe care apare valoarea 𝑥 în matrice, sub forma unui tuplu (linie, coloană), sau valoarea None dacă 𝑥 nu se găsește în matrice.''''''
def matrice_rand(n,m):
    M = [[random.randint(0,100)] for x in range(m)]
    M.sort()
    for i in range(1, n):
        M[0].extend([M[0][i - 1] + random.randint(1,10)])
    for i in range(1, m):
        for j in range(1, n):
            M[i].extend([max(M[i][j - 1], M[i - 1][j]) + random.randint(1,10)])
    return M

def O_mn(x,M,m,n):
    for i in range(m):
        for j in range (n):
            if x== M[i][j]:
                return (i,j)
    return None
def O_mlogn(x,M,m,n):
    for i in range(m):
        st=0
        dr=n-1
        while(st<dr):
            m=(st+dr)//2
            if(M[i][m]==x):
                return i,m
            elif(x>M[i][m]):
                st=m+1
            else:
                dr=m-1
    return None
def O_mplusn(x,M,m,n):
    i = 0
    j = n-1
    while(i>=0 and i <m and j<n and j>0):
        if(x==M[i][j]):
            return i,j
        elif(x<M[i][j]):
            j-=1
        else:
            i+=1
    return None

m= int(input())
n= int(input())
M=[[x+1] for x in range(m)]
for i in range(1,n):
    M[0].extend([M[0][i-1]+1])
for i in range(1,m):
    for j in range(1,n):
        M[i].extend([max(M[i][j-1],M[i-1][j])+1])

M2=matrice_rand(n,m)
for list in M2:
    print(list)
x=M2[2][2]
print(x)
print(O_mlogn(x,M2,m,n))


'''

''''''
#Tema 4
n=int(input("n="))
A= [float(x) for x in input().split()]
x= float(input("x="))
L=[]
if(x>=1):
    L=A.sort(reverse=True)
elif(x<=-1):
    A.sort()
    if(n%2!=0):
        st = 0
        dr = n
        for i in range(n + 1):
            if (i % 2 == 0):
                L.extend([A[st]])
                st += 1
            else:
                L.extend([A[dr]])
                dr -= 1
    if(n%2==0):
        st = 0
        dr = n
        for i in range(n + 1):
            if (i % 2 != 0):
                L.extend([A[st]])
                st += 1
            else:
                L.extend([A[dr]])
                dr -= 1
elif(x>0):
    L=A.sort()
else:
    A.sort(reverse=True)
    if (n % 2 != 0):
        st = 0
        dr = n
        for i in range(n + 1):
            if (i % 2 == 0):
                L.extend([A[st]])
                st += 1
            else:
                L.extend([A[dr]])
                dr -= 1
    if (n % 2 == 0):
        st = 0
        dr = n
        for i in range(n + 1):
            if (i % 2 != 0):
                L.extend([A[st]])
                st += 1
            else:
                L.extend([A[dr]])
                dr -= 1


print(A)
print(L)
print("P=",end="")
for i in range (n,0,-1):
    print(L[n-i],"* x ^",i," + ",end=" ")
''''''
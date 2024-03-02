'''2.
s=input()
f=""
x=s[0]

v1.
s=s.replace(x,"")


v2.
for i in range(len(s)):
    if(x!=s[i]):
        f+=s[i]
print(f"Dupa stergerea literei {x} sirul obtinut este {f}, de lungime {len(f)}")


s=input("s=")
t=input("t=")
i=s.find(t,0)
while(i!=-1):
    print(i,end=" ")
    i=s.find(t,i+1)


i=-1
f=len(s)+1
while(i<=f):
    i=i+1
    f=f-1
    print(s[i:f])

s=input()
g=input("greseala=")
c=input("corect=")
s=s.replace(g,c,2)
if(s.find(g)!=-1):
    print("textul contine prea multe greseli, doar 2 au fost corectate")
else:
    print(s)


6.
p=input()
s=input()
t=input()
p=p.replace(s,t)
print(p)

7.
s=input("codul este:")
x=0
k=-1

litere=[]
nrap=[]
x=int(s[0])
for i in range (1,len(s)):
    if(s[i]>=0 and s[i]<10):
        x=x*10+int(s[i])
    else :
        litere.append(s[i])
        nrap.append([x])
        x=0
print(litere)
print(nrap)


def f(x):
    if (x.isalpha()==1):
        return " "
    return x
def g(x):
    if (x.isalpha()==0):
        return " "
    return x

s=input("codul este:")
nr="".join([f(x) for x in s])
lit="".join([g(x) for x in s])
print(nr)
print(lit)

8.
def f(x):
    if(x.isdigit()):
        return x
    return " "
s=input()
val="".join([f(x) for x in s])
val=val.split()
val=[int(x) for x in val]
print(sum(val))




s=input()
s=s.split()
if(len(s)>2):
    print("NU")
else:
    a=s[0].split("-")
    b=s[1].split("-")




#Cifrul lui Cezar

def e(x,k):
    if x.isalpha():
        x=chr(ord('a')+(ord(x)-ord('a')+k)%26)
    return x
def d(x,k):
    return e(x,26-k)

s=input("text=")
k=int(input("k="))
l=len(s)
for i in range(l):
    #print(e(s[i],k), end="")
    s = s[:i] + e(s[i], k) + s[(i + 1):]
print(s)
for  i in range(l):
    s = s[:i] + d(s[i], k) + s[(i + 1):]
print(s)

'''
#Anagrame+ Permutari
def anagrame(a,b):
    f=[0]*26
    for litera in a:
        f[ord(litera)-ord("a")] +=1
    for litera in b:
        f[ord(litera)-ord("a")] -=1
    for i in range(26):
        if(f[i]!=0):
            return False
    return True
def permutare(a,b):
    l=len(a)
    v=[0]*l
    for i in range(l):
        for j in range(l):
            if a[i]==b[j]:
                v[i]=j
                b=b[:j]+" "+b[j+1:]
                break
    for i in range(l):
        print(i+1,end=" ")
    print()
    for i in range(l):
        print(v[i]+1,end=" ")
    print()
a=input("a=")
b=input("b=")
print(anagrame(a,b))
if(anagrame(a,b)):
    permutare(a,b)
    permutare(b,a)
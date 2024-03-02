'''
f1 = open("test.in", "r")
f2 = open("test.out","w")

def prelucrare(s):
    n1=0
    n2=0
    n3=0
    inmultire=False
    egal=False
    for i in range(len(s)):
        if(ord(s[i]) == ord('=')):
            egal=True
            break
        if(egal == False):
            if(ord(s[i]) == ord('*')):
                inmultire=True
            if(inmultire == False):
                n1=10 * n1+int(s[i])
            else:
                n2=10*n2+int(s[i])
        else:
            n3=n3*10+int(s[i])
    if(n1*n2==n3):
        r="Corect"
    else:
        r="Gresit"
    return r

def prelucrare2(s):
    for i in range(len(s)):
        if(ord(s[i])== ord('*')):
            p1=i
        elif (ord(s[i]) == ord("=")):
            p2=i
    a=int(s[:p1])
    b=int(s[p1+1:p2])
    c=int(s[p2+1:])
    s=s[:len(s)-1]
    if(a*b==c):
        s=s+" "+"Corect"+"\n"
    else:
        s=s+" "+"Gresit"+"\n"
    f2.write(s)

s=f1.readline()
while s!= "":
    prelucrare2(s)
    s = f1.readline()
f1.close()
f2.close()

#d1.get('A') == 1
#d1.get('D',0) == 0

#Exercitiul 4

d1 = {'A': 1, 'B': 2, 'C': 3}
d2 = {'B': 2, 'C': 1, 'D': 4}
K = (d1.keys() | d2.keys())
d = {k: d1.get(k,0) + d2.get(k,0) for k in K}
print(d)

'''
'''
#ex 5
f1= open("test.in","r")
s= f1.readline()
c=input()
c=set(c)
x=','
s=s.replace(x," ")
s=s.split()
#print(s)
for i in range(len(s)):
    a=set(s[i])
    #print(a)
    if (a==c):
        print(s[i])
'''
'''
#ex6
l=input()
l=l.split()
t=[]
for i in range(len(l)-1):
    u=(l[i],l[i+1])
    t.append(u)
print(t)
'''

#ex7
def s(i,j):

    s="".join(str(i),"*",str(j),"=",str(i*j))
    return s

def f(n):
    l=[]
    for i in range(1,n+1):
        t=[s(i,j) for j in range(1,n+1)]
        l=l.append(t)
    print(l)
n=input()
#f(n)
s
'''
#ex 10
s= [1,2,12,123,4,3]
s.sort(key = lambda x : str(x))
print(s)
'''
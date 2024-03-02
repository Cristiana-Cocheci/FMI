#citire
f=open("input.txt","r")
d=dict()
n=int(f.readline())
l=[int(x) for x in f.readline().split()]
for stare in l:
    d[stare]=dict()
m=int(f.readline())
for i in range(m):
    l=f.readline().split()
    x=int(l[0])
    y=int(l[1])
    litera=l[2]
    d[x][litera]=y
q0=int(f.readline())
nrF=int(f.readline())
stari_finale=set([int(x) for x in f.readline().split()])
nrcuv=int(f.readline())
lista_cuv=[]
for i in range(nrcuv):
    lista_cuv.append(f.readline()[:-1])
lista_cuv=lista_cuv[:nrcuv]
f.close()
print(lista_cuv)
print(d)

def acceptat(cuvant):
    stare_curenta=q0
    while(cuvant != []):
        litera=cuvant[0]
        if(litera not in d[stare_curenta]):
            return False
        stare_noua=d[stare_curenta][litera]
        stare_curenta=stare_noua
        cuvant.pop(0)
    if(stare_curenta in stari_finale):
        return True
    return False


f=open("output.txt","w")
for cuvant in lista_cuv:
    litere_cuv=list(cuvant)
    if(acceptat(litere_cuv)):
        f.write("DA\n")
    else:
        f.write("NU\n")
f.close()


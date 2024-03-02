""" ex 1

a) Numarul de parole este 62^8
b) Timpul necesar in secunde este de 62^8/10^6 = 218340105.584896
c) Probabilitatea dupa ghicire este 0.002769990416464459
d) Inlocuim 62 cu 36 si recalculam
"""
print(pow(62,8)/pow(10,6))
saptamana= 60*60*24*7
incercari= saptamana* pow(10,6)
total= pow(62,8)
print(incercari/ total)

"""ex 2
aranjamente de 15 cate 10 = 15 fact/ 5 fact = 10897286400.0
"""

def fact(x):
    if(x==0):
        return 1
    return x*fact(x-1)
print(fact(15)/fact(15-10))

"""
ex 3
combinari de 10 luate cate 3 =120.0
"""
print(fact(10)/(fact(3)*fact(10-3)))


"""
ex 4
a) Probabilitatea= 0.2582559339525284
b) 
"""
def combinari(n,k):
    return(fact(n)/(fact(k)*fact(n-k)))
combinari_totale = combinari(20,6)
combinari_noi = combinari(13,3)
combinari_vechi= combinari(7,3)

probabilitate_calc= (combinari_noi*combinari_vechi) / combinari_totale
print(probabilitate_calc)

#b
p_6vechi= (7/20)*(6/19)*(5/18)*(4/17)*(3/16)*(2/15)
p_5vechi=(combinari(13,1)*combinari(7,5))/ combinari_totale
p_4vechi=(combinari(13,2)*combinari(7,4))/ combinari_totale
p_3vechi=(combinari(13,3)*combinari(7,3))/ combinari_totale
p_2vechi=(combinari(13,4)*combinari(7,2))/ combinari_totale
p_1vechi=(combinari(13,5)*combinari(7,1))/ combinari_totale
p_0vechi= (13/20)*(12/19)*(11/18)*(10/17)*(9/16)*(8/15)
print(p_6vechi)
print(p_5vechi)
print(p_4vechi)
print(p_3vechi)
print(p_2vechi)
print(p_1vechi)
print(p_0vechi)
# maximul probabilitatii este 2 vechi

"""
ex 5
a) 0.0017360790470034167
b) cel mai probabil 0 asi
"""
combinari_pachet= combinari(52,5)
c_asi= combinari(4,3)
c_normale= combinari(48,2)
prob= (c_asi * c_normale)/combinari_pachet
print(prob)
print()
p_0asi= (combinari(4,0)*combinari(48,5))/combinari_pachet
p_1asi=(combinari(4,1)*combinari(48,4))/combinari_pachet
p_2asi=(combinari(4,2)*combinari(48,3))/combinari_pachet
p_3asi=(combinari(4,3)*combinari(48,2))/combinari_pachet
p_4asi=(combinari(4,4)*combinari(48,1))/combinari_pachet
print(p_4asi)
print(p_3asi)
print(p_2asi)
print(p_1asi)
print(p_0asi)
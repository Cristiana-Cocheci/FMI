#include <bits/stdc++.h>
#define NMAX 2
#define nr_biti 30

struct Trie{

    struct Nod{
        int activ;
        std::vector<Nod*> copii;
        Nod():activ(0),copii(NMAX,nullptr){}
    };
    Nod *radacina;
    Trie():radacina(new Nod){}

    void modifica_numar(int x, int b)
    {
        Nod *p=radacina;

        for(int i=nr_biti; i>=0;i--)
        {
            int bit_curent= ((x & (1<<i))!=0);
            if(p->copii[bit_curent]==nullptr){
                p->copii[bit_curent]= new Nod();
            }
            p=p->copii[bit_curent];
            p->activ+=b;
        }
    }
    int xxor(int x, int l)
    {
        int aux=0;
        Nod *p=radacina;
        for(int i=nr_biti;i>=0 && p!=nullptr;i--)
        {
            int bit_l= ((l&(1<<i))!=0);
            int bit_x= ((x & (1<<i))!=0);
            if(bit_l==1){
                if(p->copii[bit_x]!=nullptr && p->copii[bit_x]->activ>0)
                    aux+= p->copii[bit_x]->activ; //xorul dintre x si soldati o sa fe 0, deci adaugam la contor
                p=p->copii[!bit_x]; //continuam sa cautam si pe partea cealalta
            }
            else{
                p=p->copii[bit_x]; //mergem mai departe pe bitii lui x (comandantul)
            }
        }
        return aux;
    }
};

int main()
{
    // freopen("input.in","r",stdin);
    int n;
    std::cin>>n;
    Trie trie;
    for(int i=0;i<n;i++)
    {
        int qq,x;
        std::cin>>qq;
        if(qq==1 || qq==2)
        {
            std::cin>>x;
            trie.modifica_numar(x,qq==1 ? 1:-1);
        }
        else
        {
            int l;
            std::cin>>x>>l;
            printf("%d\n",trie.xxor(x,l));
        }

    }
    return 0;
}

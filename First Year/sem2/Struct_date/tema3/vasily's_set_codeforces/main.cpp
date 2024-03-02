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
    int xxor(int x)
    {
        int aux=0;
        Nod *p=radacina;
        for(int i=nr_biti;i>=0;i--)
        {
            int bit_doryt= !((x & (1<<i)) !=0);
            if(p->copii[bit_doryt]!=nullptr && p->copii[bit_doryt]->activ>0)
            {
                aux|=1<<i;
                p=p ->copii[bit_doryt];
            }
            else if(p->copii[!bit_doryt]!=nullptr && p->copii[!bit_doryt]->activ>0)
            {
                p=p ->copii[!bit_doryt];
            }
            else
            {
                break;
            }

        }
        return std::max(x,aux);
    }

};

int main()
{
    //freopen("input.in","r",stdin);
    int n;
    std::cin>>n;
    Trie trie;
    for(int i=0;i<n;i++)
    {
        char t;
        int x;
        std::cin>>t;
        std::cin>>x;
        if(t=='+')
        {
            trie.modifica_numar(x,1);
        }
        else if(t=='-')
        {
            trie.modifica_numar(x,-1);
        }
        else
        {
            printf("%d\n",trie.xxor(x));
        }

    }
    return 0;
}

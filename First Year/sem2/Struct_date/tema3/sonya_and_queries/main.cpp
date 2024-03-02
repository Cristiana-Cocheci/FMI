#include <bits/stdc++.h>
#define NMAX 2
#define nr_cifre 18

struct Trie{

    struct Nod{
        int activ;
        std::vector<Nod*> copii;
        Nod():activ(0),copii(NMAX,nullptr){}
    };
    Nod *radacina;
    Trie():radacina(new Nod){}

    void modifica_numar(long long x, int b)
    {
        Nod *p=radacina;
        for(int i=0; i<nr_cifre;i++)
        {
            int cifra_curenta= x%2;
            x/=10;
            if(p->copii[cifra_curenta]==nullptr){
                p->copii[cifra_curenta]= new Nod();
            }
            p=p->copii[cifra_curenta];
            p->activ+=b;
        }
    }
    int pattern(std::string x)
    {
        Nod *p=radacina;
        std::reverse(x.begin(),x.end());
        for(int i=0;i<nr_cifre;i++)
        {
            int cifra_curenta;
            if(i<x.size())
            {
                cifra_curenta= x[i]-'0';
            }
            else{
                cifra_curenta=0;
            }
            if(p->copii[cifra_curenta]!=nullptr)
            {
                p=p->copii[cifra_curenta];
            }
            else{
                return 0;
            }
        }
        return p->activ;
    }
};

int main()
{
 //   freopen("input.in","r",stdin);
    int n;
    std::cin>>n;
    Trie trie;
    for(int i=0;i<n;i++)
    {
        char t;
        std::cin>>t;
        if(t=='+')
        {
            long long x;
            std::cin>>x;
            trie.modifica_numar(x,1);
        }
        else if(t=='-')
        {
            long long x;
            std::cin>>x;
            trie.modifica_numar(x,-1);
        }
        else
        {
            std::string p;
            std::cin>>p;
            printf("%d\n",trie.pattern(p));
        }

    }
    return 0;
}

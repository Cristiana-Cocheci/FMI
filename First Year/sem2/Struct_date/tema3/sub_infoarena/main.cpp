#include <bits/stdc++.h>
#define NMAX 26

struct Trie{

    struct Nod{
        int ultimul_cuv_activ;
        std::vector<Nod*> copii;
        Nod():ultimul_cuv_activ(0),copii(NMAX,nullptr){}
    };
    Nod *radacina;
    Trie():radacina(new Nod){}

    void insereaza_cuvant(std::string cuv)
    {
        Nod *p=radacina;
        for(int i=0; i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            if(p->copii[litera_curenta]==nullptr){
                p->copii[litera_curenta]= new Nod();
            }
            p=p->copii[litera_curenta];
            p->ultimul_cuv_activ=1;
        }
    }

    void activ(std::string cuv, int poz)
    {
        Nod *p=radacina;
        for(int i=0;i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            p=p->copii[litera_curenta];
            if(p==nullptr)
            {
                return;
            }

            if(p->ultimul_cuv_activ<poz-1){
                return;
            }
            else{
                p->ultimul_cuv_activ=poz;
            }


        }
    }
    void inactiv(std::string cuv)
    {
        Nod *p=radacina;
        for(int i=0;i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            p=p->copii[litera_curenta];
            if(p==nullptr)
            {
                return;
            }
            p->ultimul_cuv_activ=-1;
        }
    }
    int rezultat(std::string cuv,int na)
    {
        int aux=0;
        Nod *p=radacina;
        for(int i=0;i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            p=p ->copii[litera_curenta];
            if(p->ultimul_cuv_activ==na){
                p->ultimul_cuv_activ=-1;
                aux++;
            }
        }
        return aux;
    }

};

int main()
{
    freopen("sub.in","r",stdin);
    freopen("sub.out","w",stdout);
    int na;
    Trie trie;
    std::cin>>na;
    std::string cuv_init;
    for(int i=1;i<=na;i++)
    {
        std::string cuv;
        std::cin>>cuv;
        if(i==1)
        {
            cuv_init=cuv;
            for(int j=0;j<cuv.size();j++)
            {
                trie.insereaza_cuvant(cuv.substr(j));
            }
        }
        else
        {
            for(int j=0;j<cuv.size();j++)
            {
                trie.activ(cuv.substr(j),i);
            }
        }
    }
    int nb;
    std::cin>>nb;
    for(int i=0;i<nb;i++)
    {
        std::string cuv;
        std::cin>>cuv;
        for(int j=0;j<cuv.size();j++)
        {
            trie.inactiv(cuv.substr(j));
        }
    }
    int rez=0;
    for(int j=0;j<cuv_init.size();j++)
    {
        rez+=trie.rezultat(cuv_init.substr(j),na);
        //std::cout<<rez<<" "<<cuv_init.substr(j)<<"\n";
    }
    std::cout<<rez;
    return 0;
}

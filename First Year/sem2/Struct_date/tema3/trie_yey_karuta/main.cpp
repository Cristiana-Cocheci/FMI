#include <bits/stdc++.h>
#define NMAX 26

struct Trie{

    struct Nod{
        int traversari;
        std::vector<Nod*> copii;
        Nod():traversari(0),copii(NMAX,nullptr){}
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
            p->traversari++;
        }
    }
    int LCP(std::string cuv)
    {
        Nod *p=radacina;
        for(int i=0;i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            p=p ->copii[litera_curenta];
            if(p->traversari==1){
                return i;
            }
        }
        return cuv.size();
    }

};

int main()
{
    int n;
    Trie trie;
    std::vector<std::string> v;
    std::cin>>n;
    for(int i=0;i<n;i++)
    {
        std::string cuv;
        std::cin>>cuv;
        trie.insereaza_cuvant(cuv);
        v.push_back(cuv);
    }
    for(int i=0;i<v.size();i++)
    {
        std::cout<<trie.LCP(v[i])<<"\n";
    }
    return 0;
}

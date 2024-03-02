#include <iostream>
#include <bits/stdc++.h>
#define NMAX 26

struct Trie{

    struct Nod{
        bool capat;
        std::vector<Nod*> copii;
        Nod():capat(0),copii(NMAX,nullptr){}
    };
    Nod *radacina;
    Trie():radacina(new Nod){}

    int insereaza(std::string cuv)
    {
        int scot=0;
        Nod *p=radacina;
        for(int i=0; i<cuv.size();i++)
        {
            int litera_curenta= cuv[i]-'a';
            if(p->copii[litera_curenta]==nullptr){
                p->copii[litera_curenta]= new Nod();
            }
            p=p->copii[litera_curenta];
            if(p->capat==1){
                p->capat=0;
                scot=1;
            }
        }
        p->capat=1;
        return !scot;
    }
};

bool comparee(std::string a, std::string b)
{
    return (a.size()<b.size());
}

int main()
{
    freopen("input.in","r",stdin);
    int n,k;
    std::cin>>n>>k;
    std::vector <std::string> v;

    Trie trie;
    for(int i=0;i<n;i++)
    {
        std::string a;
        std::cin>>a;
        v.push_back(a);
    }

    std::sort(v.begin(),v.end(), comparee);

    int aux=0,i;
    for(i=0;i<v.size() && aux<k;i++)
    {
        aux+=trie.insereaza(v[i]);
    }
    if(aux<k){
        printf("-1");
    }
    else{
        printf("%d",v[i-1].size());
    }
    return 0;
}

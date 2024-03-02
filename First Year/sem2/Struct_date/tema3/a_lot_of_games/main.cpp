#include <iostream>
#include <bits/stdc++.h>
#define NMAX 26

struct Trie{

    struct Nod{
        bool win,lose;
        std::vector<Nod*> copii;
        Nod():win(0),lose(0),copii(NMAX,nullptr){}
    };
    Nod *radacina;
    Trie():radacina(new Nod){}
    void insereaza(std::string cuv)
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

        }
    }
    void dfs(Nod *p)
    {
        bool leaf=true;
        for(int i=0;i<NMAX;i++)
        {
            if(p->copii[i]!=nullptr){
                leaf=false;
            }
        }
        if(leaf){
            p->win=0;
            p->lose=1;
            return;
        }
        for(int i=0;i<NMAX;i++)
        {
            if(p->copii[i]!=nullptr){
                dfs(p->copii[i]);
            }
        }
        int aux_w=0,aux_l=0;
        for(int j=0;j<NMAX;j++)
        {
            if(p->copii[j]!=nullptr)
            {
                aux_w|=p->copii[j]->win;
                aux_l|=p->copii[j]->lose;
            }
        }

                p->lose=aux_w;
                p->win=aux_l;
    }
    std::string verifica(int k){
        Nod *p=radacina;
        if(p->lose==0){
            if(k%2==1){
                return "First";
            }
            return "Second";
        }
        else if(p->win==1 && p->lose==1){
            return "First";
        }
        else if(p->win==0){
            return "Second";
        }

    }
};
/*
bool comparee(std::string a, std::string b)
{
    return (a.size()<b.size());
}*/

int main()
{
    //freopen("input.in","r",stdin);
    int n,k;
    std::cin>>n>>k;
    std::vector <std::string> v;

    Trie trie;
    for(int i=0;i<n;i++)
    {
        std::string a;
        std::cin>>a;
        trie.insereaza(a);
    }
    Trie::Nod *p=trie.radacina;
    trie.dfs(p);
    //std::cout<<p->lose<<" "<<p->win<<"\n";
    std::cout<<trie.verifica(k);
    return 0;
}

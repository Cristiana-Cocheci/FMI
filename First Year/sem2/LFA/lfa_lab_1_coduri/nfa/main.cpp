///nfa
//numai lambda-nfa ul e normalizat
#include <bits/stdc++.h>
#define NMAX 10000

using namespace std;

ifstream fin("intrare.in");
ofstream fout("iesire.out");

struct tuplu
{
    int dest;
    char litera;
};

int N,M,stari[NMAX],finale[NMAX],nrfin,q0;
vector <tuplu> muchii[NMAX];
vector <int> path, path_final;


void citire()
{
    fin >> N;
    for(int i=1;i<=N;i++)
    {
        fin >> stari[i];
    }
    fin >> M;
    for(int i=1;i<=M;i++)
    {
        int x,y;
        char l;
        fin >>x>>y>>l;
        struct tuplu t;
        t.dest=y;
        t.litera=l;
        muchii[x].push_back(t);
    }
}


bool acceptat(int sf)
{
    for(int i=0;i<nrfin;i++)
    {
        if(sf==finale[i])
        {
            return true;
        }
    }
    return false;
}

void dfs(char *cuvant,int stare, int poz)
{
    if(poz==strlen(cuvant))
    {
        if(acceptat(stare))
        {
            path_final=path;
        }
    }
    for(int i=0; i < muchii[stare].size(); i++)
    {
        if(muchii[stare][i].litera==cuvant[poz])
        {
            int stare_noua=muchii[stare][i].dest;
            path.push_back(stare_noua);
            dfs(cuvant,stare_noua,poz+1);
            path.pop_back();
        }
    }
}

void nfa()
{
    int k;
    fin >> q0 >> nrfin;
    for(int i=0;i<nrfin;i++)
    {
        fin >> finale[i];
    }
    fin >> k;
    path.push_back(q0);
    for(int kk=0;kk<k;kk++)
    {
        path_final.clear();
        char cuvant[100000];
        fin >> cuvant;
        dfs(cuvant,q0,0);
        if(path_final.size()>0)
        {
            fout << "DA\n";
            for (int i=0;i<path_final.size();i++)
            {
                fout<< path_final[i]<<" ";
            }
            fout <<"\n";
        }
        else
        {
            fout<< "NU\n";
        }
    }
}

int main()
{
    citire();
    /*for(int i=1;i<=N;i++)
    {
        fout << stari[i]<<": ";
        for(unsigned int j=0; j< muchii[stari[i]].size();j++)
        {
            int a = muchii[stari[i]][j].dest;
            fout << a <<", ";
        }
        fout <<"\n";
    }*/
    nfa();
    return 0;
}


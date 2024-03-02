///dfa
//numai lambda-nfa ul e normalizat
#include <bits/stdc++.h>
#define NMAX 10000

using namespace std;

ifstream fin("input.txt");
ofstream fout("output.txt");

struct tuplu
{
    int dest;
    char litera;
};

int N,M,stari[NMAX],finale[NMAX],nrfin,q0,drumuri[NMAX];
vector <tuplu> muchii[NMAX];

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

int dfs(char *cuvant,int stare, int poz)
{
    if(poz==strlen(cuvant))
    {
        return stare;
    }
    for(int i=0; i < muchii[stare].size(); i++)
    {
        if(muchii[stare][i].litera==cuvant[poz])
        {
            int stare_noua=muchii[stare][i].dest;
            drumuri[poz+1]=stare_noua;
            return dfs(cuvant,stare_noua,poz+1);

        }
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

void dfa()
{
    int k;
    fin >> q0 >> nrfin;
    for(int i=0;i<nrfin;i++)
    {
        fin >> finale[i];
    }
    drumuri[0]=q0;
    fin >> k;
    for(int kk=0;kk<k;kk++)
    {
        char cuvant[100000];
        fin >> cuvant;
        int sf=dfs(cuvant,q0,0);
        fout<< sf<<" ";
        if(acceptat(sf))
        {
            fout << "DA\n";
            for (int i=0;i<strlen(cuvant);i++)
            {
                fout<< drumuri[i]<<" ";
            }
            fout<<sf<<"\n";
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
    dfa();
    return 0;
}


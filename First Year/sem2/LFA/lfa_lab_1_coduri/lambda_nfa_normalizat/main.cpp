#include <bits/stdc++.h>
#define NMAX 10000

using namespace std;

ifstream fin("input.in");
ofstream fout("output.out");

// lista de adiacenta
struct tuplu
{
    int dest;
    char litera;
};

int N,M,stari[NMAX],finale[NMAX],nrfin,q0, visited[NMAX][NMAX],q_init;

///pt lambda nfa fac o matrice visited[][] cu dimensiunile stare si nr de litere din cuvant (pozitia la care ma aflu)
/// pentru cicluri doar din lambda

vector <tuplu> muchii[NMAX];
vector <int> path, path_final;


//am normalizat starile in numere naturale consecutive
int corespondenta_normalizare(int stare)
{
    for (int i=0;i<N;i++)
    {
        if(stari[i]==stare)
        {
            return i;
        }
    }
}

void citire()
{
    fin >> N;
    for(int i=0;i<N;i++)
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
        t.dest=corespondenta_normalizare(y);
        t.litera=l;
        muchii[corespondenta_normalizare(x)].push_back(t);
    }
}

//verifica daca starea finala obtinuta face parte din starile finale
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


//parcurgerea grafului obtinut
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
            visited[stare_noua][poz]=1;
            dfs(cuvant,stare_noua,poz+1);
            path.pop_back();
            visited[stare_noua][poz]=1;
        }
        else if(muchii[stare][i].litera== 'L')
        {
            int stare_noua=muchii[stare][i].dest;
            if(visited[stare_noua][poz]==0)   //daca intalnim ciclu oprim parcurgerea si functia recursiva se intoarce in apelul anterior
            {
                visited[stare_noua][poz]=1;
                path.push_back(stare_noua);
                dfs(cuvant,stare_noua,poz);
                path.pop_back();
            }
        }
    }
}

//afisarea drumului
void afisare_path()
{
    for (int i=0;i<path_final.size();i++)
    {
        fout<< stari[path_final[i]]<<" ";
    }
        fout <<"\n";
}

void lambda_nfa()
{
    int k;
    fin >> q_init >> nrfin;
    q0=corespondenta_normalizare(q_init);
    for(int i=0;i<nrfin;i++)
    {
        int aux;
        fin >> aux;
        finale[i]=corespondenta_normalizare(aux);
    }
    fin >> k;
    path.push_back(q0);
    visited[q0][0]=1;
    for(int kk=0;kk<k;kk++)
    {
        path_final.clear(); //resetez path_final, ca sa nu creada ca un cuvant e acceptat daca anteriorul a fost
        char cuvant[100000];
        fin >> cuvant;
        for(int i=0;i<=k;i++)
        {
            for(int j=0;j<=strlen(cuvant);j++)
            {
                visited[i][j]=0;
            }
        }
        dfs(cuvant,q0,0);
        if(path_final.size()>0) // daca s-a ajuns la stare finala inseamna ca path_final nu e gol
        {
            fout << "DA\n";
            afisare_path();
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
    lambda_nfa();
    return 0;
}



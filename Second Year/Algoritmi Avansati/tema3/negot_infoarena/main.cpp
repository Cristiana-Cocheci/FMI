#include <stdio.h>
#include <bits/stdc++.h>
#define NMAX 1005
#define MMAX 400005

using namespace std;

vector<vector<pair<int,int>>> capacitate;
int src, dest;
vector<int> level;
int N,M,K, flow_rezultat=0; //N e numarul de noduri


bool bfs(){
    queue<int> coada;
    bool ok = 0;

    for(int i=0;i<=N; i++){
        level[i] = N;
    }
    level[src] = 0;
    coada.push(src);

    while(!coada.empty()){
        int nod = coada.front();
        coada.pop();

        for(int i=0; i<capacitate[nod].size(); i++){
            int vec = capacitate[nod][i].first;
            //cout<< nod<<" "<<vec<<" "<< capacitate[nod][i].second<<" "<<level[vec]<<" "<<level[nod]+1<<"\n";
            if(capacitate[nod][i].second && level[vec] > level[nod]+1){
                if(vec == dest){
                    ok=1; //am ajuns la destinatie
                }
                else{
                    level[vec] = level[nod]+1;
                    coada.push(vec);
                }
            }
        }
    }
    return ok;
}

int dfs(int nod, int bottleneck){
    if(!bottleneck){
        return 0;
    }

    if(nod == dest){

        //cout<< "b: "<<bottleneck<<"\n";
        return bottleneck;
    }
    int maxflow = bottleneck;
    for(int i=0; i<capacitate[nod].size();i++){
        int vec = capacitate[nod][i].first;
        if(capacitate[nod][i].second && level[vec] > level[nod]){
            //cout<< nod<< " "<< vec<<" "<<capacitate[nod][i].second<<"\n";
            int flow_nou = dfs(vec, min(bottleneck, capacitate[nod][i].second));
            bottleneck -= flow_nou;
            capacitate[nod][i].second-= flow_nou;
            for(int j =0;j<capacitate[vec].size();j++){
                if(capacitate[vec][j].first == nod){
                    capacitate[vec][j].second += flow_nou;
                    break;
                }
            }
        }
    }
    return maxflow - bottleneck;
}

bool dinic(){
    bool ok = 0;
    if(!bfs()){
        return 0;
        //nu se poate ajunge din src la dest pe graf
    }

    int aux = dfs(src,K);
    flow_rezultat += aux;
    //cout<<aux<<"\n";
    while(aux)
    {
        ok=1;
        aux = dfs(src,K);
        //cout<<aux<<"\n";
        flow_rezultat += aux;
    }
    return ok;
}

int main(){
    freopen("negot.in","r",stdin);
    freopen("negot.out","w",stdout);
    int Np;
    cin>>Np>>M>>K;
    N = Np+ M;
    src = N+1;
    dest = N;
    level.resize(N+2,0);
    capacitate.resize(N+2);
    for(int i=0; i<Np;i++){
        capacitate[src].push_back({i,K});
        int cnt;
        cin>>cnt;
        for(int j = 0; j<cnt;j++){
            int x;
            cin>>x;
            x--;
            capacitate[i].push_back({Np+x,1});
            capacitate[Np+x].push_back({i,0});


        }
    }
    for(int i=Np;i<Np+M;i++){
        capacitate[i].push_back({dest,1});
    }

    /*for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }*/


    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);

    cout<<flow_rezultat;

    return 0;
}

/**/

/*#include <stdio.h>
#include <bits/stdc++.h>
#define NMAX 1005
#define MMAX 405

using namespace std;

int capacitate[NMAX+MMAX][NMAX+MMAX];
int src, dest;
int level[NMAX+MMAX];
int N,M,K, flow_rezultat=0; //N e numarul de noduri


bool bfs(){
    queue<int> coada;
    bool ok = 0;

    for(int i=0;i<=N; i++){
        level[i] = N;
    }
    level[src] = 0;
    coada.push(src);

    while(!coada.empty()){
        int nod = coada.front();
        coada.pop();

        for(int i=0; i<=N; i++){
            //cout<< nod<<" "<<i<<" "<< capacitate[nod][i]<<" "<<level[i]<<" "<<level[nod]+1<<"\n";
            if(capacitate[nod][i] && level[i] > level[nod]+1){
                if(i == dest){
                    ok=1; //am ajuns la destinatie
                }
                else{
                    level[i] = level[nod]+1;
                    coada.push(i);
                }
            }
        }
    }
    return ok;
}

int dfs(int nod, int bottleneck){
    if(nod == dest){
        cout<< "b: "<<bottleneck<<"\n";
        return bottleneck;
    }
    int maxflow = bottleneck;
    for(int i=0; i<=N;i++){
        if(capacitate[nod][i] && level[i] > level[nod]){
            cout<< nod<< " "<< i<<" "<<capacitate[nod][i]<<"\n";
            int flow_nou = dfs(i, min(bottleneck, capacitate[nod][i]));
            bottleneck -= flow_nou;
            capacitate[nod][i]-= flow_nou;
            capacitate[i][nod] += flow_nou;
        }
    }
    return maxflow - bottleneck;
}

bool dinic(){
    bool ok = 0;
    if(!bfs()){
        return 0;
        //nu se poate ajunge din src la dest pe graf
    }
    int aux = dfs(src,K);
    flow_rezultat += aux;
    cout<<aux<<"\n";
    while(aux)
    {
        ok=1;
        aux = dfs(src,K);
        flow_rezultat += aux;
        cout<<aux<<"\n";
    }
    return ok;
}

int main(){
    freopen("negot.in","r",stdin);
    freopen("negot.out","w",stdout);
    int Np;
    cin>>Np>>M>>K;
    N = Np+ M;
    src = N+1;
    dest = N;
    for(int i=0; i<Np;i++){
        capacitate[src][i]=K;
        int cnt;
        cin>>cnt;
        for(int j = 0; j<cnt;j++){
            int x;
            cin>>x;
            x--;
            capacitate[i][Np+x] = 1;
            capacitate[Np+x][dest] = 1;
        }
    }
    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);

    cout<<flow_rezultat;

    return 0;
}
/**/

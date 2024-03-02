#include <stdio.h>
#include <bits/stdc++.h>
#define NMAX 102

using namespace std;

int capacitate[NMAX][NMAX];
vector<int> graf[NMAX][NMAX];
int src = 101, dest = 100;
int level[NMAX], rez[5002], nrez=0;
int N,K;


bool bfs(){
    queue<int> coada;
    bool ok = 0;

    for(int i=0;i<NMAX; i++){
        level[i] = NMAX;
    }
    level[src] = 0;
    coada.push(src);

    while(!coada.empty()){
        int nod = coada.front();
        coada.pop();

        for(int i=0; i<NMAX; i++){
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
        return bottleneck;
    }
    int maxflow = bottleneck;
    for(int i=0; i<NMAX;i++){
        if(capacitate[nod][i] && level[i] > level[nod]){
            //cout<< nod<< " "<< i<<"\n";
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

    while(dfs(src, K))
    {
        ok=1;
    }
    return ok;
}

int main(){
    freopen("ghizi.in","r",stdin);
    freopen("ghizi.out","w",stdout);
    cin>>N>>K;

    for(int i=0; i<N;i++){
        int x,y;
        cin>>x>>y;
        capacitate[x][y]++;
        graf[x][y].push_back(i+1);
    }
    capacitate[src][0] = K;
    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);

    for(int i=0;i<100; i++){ //parcurgem muchiile folosite, adaugam voluntarii corespunzatori muchiilor  folosite;
        for(int j = i+1; j<=100; j++){
            while(capacitate[i][j] < graf[i][j].size()){
                rez[graf[i][j][graf[i][j].size()-1]] = 1;
                graf[i][j].pop_back();
                nrez++;
            }
        }
    }
    cout<<nrez<<"\n";
    for(int i=0; i<=5002; i++){
        if(rez[i]==1)
            cout<< i<<" ";
    }

    return 0;
}

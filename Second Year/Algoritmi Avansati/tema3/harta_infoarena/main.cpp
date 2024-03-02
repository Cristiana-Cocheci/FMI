#include <stdio.h>
#include <bits/stdc++.h>
#define NMAX 1005
#define MMAX 400005

using namespace std;

vector<vector<pair<int,int>>> capacitate;
int src, dest, maxim;
vector<int> level;
int N, flow_rezultat=0; //N e numarul de noduri


bool bfs(){
    queue<int> coada;
    bool ok = 0;

    for(int i=0;i<N; i++){
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
    int aux = dfs(src, maxim);
    flow_rezultat += aux;
    //cout<<aux<<"\n";
    while(aux)
    {
        ok=1;
        aux = dfs(src, maxim);
        //cout<<aux<<"\n";
        flow_rezultat += aux;
    }
    return ok;
}

int main(){
    freopen("harta.in","r",stdin);
    freopen("harta.out","w",stdout);
    int Np;
    cin>>Np;
    N = 2*Np+ 2;
    src = 2*Np;
    dest = N - 1;
    level.resize(N,0);
    capacitate.resize(N);
    maxim = 0;
    for(int i=0; i<Np;i++){
        int in, out;
        cin>>out>>in;
        maxim+=out;

        capacitate[src].push_back({i,in});
        capacitate[i].push_back({src,0});

        capacitate[Np+i].push_back({dest,out});
        capacitate[dest].push_back({Np+i,0});
        for(int j=Np; j<2*Np; j++){
            if(Np+i!=j){
                capacitate[i].push_back({j, 1});
                capacitate[j].push_back({i, 0});
            }
        }
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

    cout<<flow_rezultat<<"\n";
    for(int i=Np; i<=2*Np;i++){
        for(int j=0; j<capacitate[i].size();j++){
            if(capacitate[i][j].second == 1 && capacitate[i][j].first <Np){
                int x = i-Np+1, y = capacitate[i][j].first +1;
                cout<<x<<" "<<y<<"\n";
            }
        }
    }

    /*for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }*/
    return 0;
}

#include <iostream>
#include <bits/stdc++.h>
#define INF 1000000000

using namespace std;

//gasim drumul de cost minim de la src la dest --dijkstra
//calculam pentru fiecare lanterna cu ce cost ajunge la dest --dijkstra din toate lanternele
//facem cautare binara pe vectorul de lanterne (cautam drumul de cost minim)

int N,K,M;
int prieteni[60];

struct drum{
    int vec, c, w;
};

int dijkstra_lanterna_k (vector<vector<drum>> &graf, int k){
    vector<vector<int>> distante(N,vector<int>(K+1,INF));
    queue<pair<pair<int,int>,int>> coada; //cost, nod, lanterna
    coada.push({{0,0},k});
    distante[0][k]=0;
    while(!coada.empty()){
        int nod=coada.front().first.second, cost=coada.front().first.first, llant = coada.front().second;
        coada.pop();
        //cout<<nod<<" "<<llant<<", ";
        if(distante[nod][llant]<cost){
            continue;
        }
        if(nod==N-1){
            continue;
        }

        for(int i=0;i<graf[nod].size();i++){
            int vec = graf[nod][i].vec, c = graf[nod][i].c, w = graf[nod][i].w;
            int lant=llant;
            if(lant-w>=0){
                if(prieteni[vec]){
                    lant=k;
                }
                else{
                    lant-=w;
                }
                if(distante[vec][lant] > c+cost){
                    distante[vec][lant] = c+cost;
                    coada.push({{(c+cost),vec},lant});
                }
            }
        }
    }
    int rez=INF;
    for(int i=0;i<=k;i++){
        rez=min(rez, distante[N-1][i]);
    }
    return rez;
}

int main(){
    freopen("lanterna.in","r",stdin);
    freopen("lanterna.out","w",stdout);
    cin>>N>>K;
    for(int i=0;i<N;i++){
        cin>>prieteni[i];
    }
    cin>>M;
    vector<vector<drum>> graf(N);
    for(int i=0;i<M;i++){
        int x,y,c,w;
        cin>>x>>y>>c>>w;
        x--;y--;
        struct drum d;
        d.c=c; d.w=w;
        d.vec=y;
        graf[x].push_back(d);
        d.vec=x;
        graf[y].push_back(d);
    }
    int drum_minim=dijkstra_lanterna_k(graf, K);
    cout<<drum_minim<<" ";
    /*for(int i=0;i<=K;i++){
        cout<<dijkstra_lanterna_k(graf,i)<<"\n";
    }*/
    int st = 1, dr = K;
    while (st <= dr) {
        int mij = (st + dr) / 2;
        int cost = dijkstra_lanterna_k(graf, mij);
        if (cost <= drum_minim)
            dr = mij - 1;
        else
            st = mij + 1;
    }
    cout << st ;

    return 0;
}

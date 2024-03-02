#include <iostream>
#include <bits/stdc++.h>
#include <limits>

#define INF 1e14

using namespace std;

int N,M,A,B,C;

vector<pair<long long,int>> dijkstra(vector<vector<pair<int,int>>> &graf, int nod){
    vector<pair<long long,int>> distante_tati(N+1,{INF,-1});
    distante_tati[nod]={0,-1};

    priority_queue<pair<long long,int>> coada; //cost,nod
    coada.push({0,nod});
    while(!coada.empty()){
        long long n=coada.top().second, co=-coada.top().first;
        coada.pop();
        if (distante_tati[n].first < co) {
            continue;
        }
        for(int i=0;i<graf[n].size();i++){
            long long vec=graf[n][i].second, c=graf[n][i].first;
            if(distante_tati[vec].first>co+c)
            {
                distante_tati[vec]={(co+c), n};
                coada.push({-(co+c),vec});
            }
        }
    }
    return distante_tati;
}

void reconstruim_lant(vector<pair<long long,int>> &dist, int X){
    vector<int> lant;
    lant.push_back(X);
    while(dist[X].second !=-1){
        X=dist[X].second;
        lant.push_back(X);
    }
    cout<< lant.size()<<" ";
    for(int i=0;i<lant.size();i++){
        cout<<lant[i]<<" ";
    }
    cout<<"\n";
}
vector<vector<pair<int,int>>> graf;
int main()
{
    freopen("trilant.in","r",stdin);
    freopen("trilant.out","w",stdout);
    cin>>N>>M>>A>>B>>C;
    graf.resize(N+1); //cost, nod
    for(int i=0;i<M;i++){
        int x,y,c;
        cin>>x>>y>>c;
        graf[x].push_back({c,y});
        graf[y].push_back({c,x});
    }
    vector<pair<long long,int>> distA, distB, distC; //cost, nod
    distA=dijkstra(graf,A);
    distB=dijkstra(graf,B);
    distC=dijkstra(graf,C);

    /*for(int i=1;i<=N;i++){
        cout<<i<<" "<<distA[i].first<<" "<<distA[i].second<<"\n";
    }
    for(int i=1;i<=N;i++){
        cout<<i<<" "<<distB[i].first<<" "<<distB[i].second<<"\n";
    }
    for(int i=1;i<=N;i++){
        cout<<i<<" "<<distC[i].first<<" "<<distC[i].second<<"\n";
    }*/

    //vedem cine e X
    long long sum=INF,X=-1;
    for(int i=1;i<=N;i++){
        long long s=distA[i].first + distB[i].first + distC[i].first;
        if(s<sum){
            sum=s;
            X=i;
        }
    }
    cout<<sum<<"\n";

    //reconstruim cele 3 lanturi
    reconstruim_lant(distA,X);
    reconstruim_lant(distB,X);
    reconstruim_lant(distC,X);

    return 0;
}

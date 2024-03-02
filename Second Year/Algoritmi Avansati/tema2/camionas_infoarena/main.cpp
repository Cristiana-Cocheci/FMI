#include <iostream>
#include <bits/stdc++.h>
#define INF 500001
using namespace std;

int N,M,G;

int dijkstra(vector<vector<pair<int,int>>> &graf){
    vector<int> distante(N,INF);
    priority_queue<pair<int,int>> pq;
    pq.push({0,0}); //cost 0, nod pornire 0
    distante[0]=0;
    while(!pq.empty()){
        int nod = pq.top().second, co = -pq.top().first;
        pq.pop();

        if(distante[nod]<co){
            continue;
        }
        for(int i=0;i<graf[nod].size();i++){
            int vec = graf[nod][i].second, c = graf[nod][i].first;

            if(distante[vec] > c+co){
                distante[vec]=co+c;
                pq.push({-(co+c), vec});
            }
        }
    }
    return distante[N-1];
}

int main()
{
    freopen("camionas.in","r",stdin);
    freopen("camionas.out","w",stdout);
    cin>>N>>M>>G;
    vector<vector<pair<int,int>>> graf(N);
    for(int i=0;i<M;i++){
        int x,y,c;
        cin>>x>>y>>c;
        x--;y--;
        c= c<G;
        graf[x].push_back({c,y});
        graf[y].push_back({c,x});
    }
    cout<<dijkstra(graf);
    return 0;
}

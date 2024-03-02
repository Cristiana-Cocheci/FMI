#include <iostream>
#include <bits/stdc++.h>

using namespace std;

int P,N,M;
#define INF 1000000005

void pct_a(vector<vector<pair<int,int>>> &graf, vector<int> &Dmax){
    int dist_max=-1;
    queue<int>coada;
    coada.push(0);
    vector<bool> vizitat(N,0);
    while(!coada.empty()){
        int nod_curent=coada.front();
        coada.pop();
        if(Dmax[nod_curent]>dist_max){
            dist_max=Dmax[nod_curent];
        }
        for(int i=0;i<graf[nod_curent].size();i++){
            int vec=graf[nod_curent][i].second, c=graf[nod_curent][i].first;
            if(!vizitat[vec] && c<=Dmax[0]){
                coada.push(vec);
                vizitat[vec]=1;
            }
        }
    }
    cout<<dist_max;
}
void pct_b(vector<vector<pair<int,int>>> &graf, vector<int> &Dmax){

    priority_queue<pair<int,pair<int,int>>> coada;//insula si dragonul si costul actual
    coada.push({0,{0,Dmax[0]}});
    int dist_minima=INF;
    vector<int>dragoni_max(N,-1);
    dragoni_max[0]=Dmax[0];
    while(!coada.empty()){
        int insula_mea=coada.top().second.first, dragon=coada.top().second.second,co=-coada.top().first;
        coada.pop();
        if(insula_mea==N-1){
            cout<<dist_minima;
            return;
        }
        //cout<<insula_mea<<" "<<dragon<<" "<<co<<"\n";
        for(int i=0;i<graf[insula_mea].size();i++){
            int vec=graf[insula_mea][i].second, c=graf[insula_mea][i].first;
            if(c<=dragon)
            {
                int dragonnou=max(dragon,Dmax[vec]);
                if(dragonnou>dragoni_max[vec]){
                    coada.push({-(co+c),{vec,dragonnou}});
                    dragoni_max[vec]=dragonnou;
                }

                if(vec==N-1){
                    dist_minima=min(dist_minima,co+c);
                }
            }
        }
    }

}

int main()
{
    freopen("dragoni.in","r",stdin);
    freopen("dragoni.out","w",stdout);
    cin>>P>>N>>M;
    vector<int> Dmax(N); //distanta unui dragon de tip i
    vector<vector<pair<int,int>>> graf(N);
    for(int i=0;i<N;i++){
        cin>> Dmax[i];
    }

    for(int j=0;j<M;j++){
        int x,y,c;
        cin>>x>>y>>c;
        x--;y--;
        graf[x].push_back({c,y});
        graf[y].push_back({c,x});

    }
    if(P==1){
        pct_a(graf,Dmax);
    }
    else{
        pct_b(graf,Dmax);
    }
    return 0;
}

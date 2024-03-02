#include <iostream>
#include <bits/stdc++.h>
#include <limits>

using namespace std;

int N,M,Q;
#define INF 10008


vector<vector<pair<int,int>>> apm_prim(vector<vector<pair<int,int>>> &graf){
    vector<int> distante(N,INF);
    vector<bool> vizitat(N,0);
    vector<vector<pair<int,int>>> apm(N);
    int nod_curent=0;
    distante[0]=0;

    for(int i=0;i<N-1;i++){
        vizitat[nod_curent]=1;
        int min_nod, min_dist =INF;
        for(int j=0;j<graf[nod_curent].size();j++){
            int vec=graf[nod_curent][j].second,c=graf[nod_curent][j].first;

            if(!vizitat[vec]){
                int distanta_curenta = distante[vec];
                int distanta_noua = c;
                if(distanta_noua < distanta_curenta){
                    distante[vec] = distanta_noua;
                }
                if(distante[vec] < min_dist){
                    min_dist = distante[vec];
                    min_nod = vec;
                }
            }
        }
        for(int j=0;j<N;j++){
            if(distante[j] < min_dist && !vizitat[j]){
                    min_dist = distante[j];
                    min_nod = j;
            }
        }
        apm[nod_curent].push_back({min_dist,min_nod});
        apm[min_nod].push_back({min_dist,nod_curent});
        nod_curent=min_nod;
    }
    return apm;
}
bool comparCosturi(pair<pair<int,int>,int> m1, pair<pair<int,int>,int> m2){
    int c1=m1.second, c2=m2.second;
    return c1<c2;
}

vector<vector<pair<int,int>>> apm_kruskal(vector<vector<pair<int,int>>> &graf){
    vector<pair<pair<int,int>,int>> muchii;
    vector<vector<pair<int,int>>> apm(N);
    for(int i=0;i<N;i++){
        for(int j=0;j<graf[i].size();j++){
            muchii.push_back({{i,graf[i][j].second},graf[i][j].first});
        }
    }
    sort(muchii.begin(),muchii.end(),comparCosturi);
    vector<int>reprezentanti(N);
    for(int i=0;i<N;i++){
        reprezentanti[i]=i;
    }
    for(int i=0;i<muchii.size();i++){
        pair<pair<int,int>,int> muchie=muchii[i];
        int x=muchie.first.first, y=muchie.first.second, c=muchie.second;
        if(reprezentanti[x] != reprezentanti[y]){
            int rx =reprezentanti[x], ry = reprezentanti[y];
            for(int j=0;j<N;j++){
                if(reprezentanti[j]==ry){
                    reprezentanti[j]=rx;
                }
            }
            apm[x].push_back({c,y});
            apm[y].push_back({c,x});
        }

    }
    return apm;
}

int bfs_cost_max(vector<vector<pair<int,int>>> &apm, int x, int y){
    queue<int> coada;
    vector<int> costuri_max(N,-1);
    vector<bool> vizitat(N,0);
    coada.push(x);
    while(!coada.empty()){
        int n=coada.front();
        coada.pop();
        vizitat[n]=1;
        for(int i=0;i<apm[n].size();i++){
            int vec=apm[n][i].second, c=apm[n][i].first;
            if(!vizitat[vec]){
                coada.push(vec);
                costuri_max[vec]=max(costuri_max[n],c);
            }
        }

    }
    return costuri_max[y];
}



void afisare(vector<vector<pair<int,int>>> &graf){
    cout<<endl<<endl;
    for(int i=0;i<N;i++){
        cout<<i<<": ";
        for(int j=0;j<graf[i].size();j++){
            cout<<graf[i][j].second<<" ";
        }
        cout<<endl;
    }

}

int main()
{
    freopen("apm2.in","r",stdin);
    freopen("apm2.out","w",stdout);
    cin>>N>>M>>Q;
    vector<vector<pair<int,int>>> graf(N); //cost, vecin
    for(int i=0;i<M;i++){
        int x,y,c;
        cin>>x>>y>>c;
        x--;y--;
        graf[x].push_back({c,y});
        graf[y].push_back({c,x});
    }
    vector<vector<pair<int,int>>> apm = apm_kruskal(graf);
    //afisare(apm);
    for(int q=0;q<Q;q++){
        int x,y;
        cin>>x>>y;
        x--;y--;
        int cost_max_pe_drum=bfs_cost_max(apm,x,y);
        cout<<cost_max_pe_drum-1<<"\n";
    }
    return 0;
}

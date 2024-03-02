#include <iostream>
#include <bits/stdc++.h>

//disjoint set union, ca la kruskall
//inseram nodurile unul cate unul, o luam de la coada la cap

using namespace std;

int N;
int dirx[4]={0,0,1,-1};
int diry[4]={1,-1,0,0};

int find_parinte(int nod,vector<int> &parinte){
    int cnod=nod;
    while(parinte[nod]!=nod){
        nod=parinte[nod];
    }
    parinte[cnod]=nod;
    return nod;
}

int main()
{
    freopen("bile.in","r",stdin);
    freopen("bile.out","w",stdout);
    cin>>N;
    vector<int> noduri_scoase(N*N);
    vector<bool> activ(N*N,0);
    vector<int> parinte(N*N,-1);
    vector<int> dimensiuneP(N*N,0);
    for(int i=N*N-1;i>=0;i--){
        int x,y;
        cin>>x>>y;
        x--;y--;
        noduri_scoase[i]=N*x+y;
    }
    //luam nodurile si le adaugam in graf
    int dmax=0;
    for(int i=0;i<N*N;i++){
        activ[noduri_scoase[i]]=1;
        parinte[noduri_scoase[i]]=noduri_scoase[i];
        dimensiuneP[noduri_scoase[i]]=1;
        int x=noduri_scoase[i]/N, y=noduri_scoase[i]%N;
        for(int j=0;j<4;j++){
            int vx,vy;
            vx=x+dirx[j];
            vy=y+diry[j];
            if(vx>=0 && vx<N && vy>=0 && vy<N){
                int vec = vx*N+vy;
                if(activ[vec] && find_parinte(noduri_scoase[i],parinte) != find_parinte(vec,parinte)){
                    dimensiuneP[find_parinte(noduri_scoase[i],parinte)]+=dimensiuneP[find_parinte(vec,parinte)];
                    parinte[find_parinte(vec,parinte)]=find_parinte(noduri_scoase[i],parinte);
                }
            }
        }
        if(dimensiuneP[find_parinte(noduri_scoase[i],parinte)]>dmax){
            dmax=dimensiuneP[find_parinte(noduri_scoase[i],parinte)];
        }
        noduri_scoase[i]=dmax;
    }
    for(int i=N*N-2;i>=0;i--){
        cout<<noduri_scoase[i]<<"\n";
    }
    cout<<0;
    return 0;
}

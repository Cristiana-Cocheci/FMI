#include <iostream>
#include <bits/stdc++.h>


using namespace std;

int N,M,A,platim=0, vindem=0,conexe=1;


int find_parinte(int nod,vector<int> &parinte){
    int cnod=nod;
    while(parinte[nod]!=nod){
        nod=parinte[nod];
    }
    parinte[cnod]=nod;
    return nod;
}


int main(){
    freopen("rusuoaica.in","r",stdin);
    freopen("rusuoaica.out","w",stdout);
    cin>>N>>M>>A;
    vector<int> parinte(N,-1);
    priority_queue<pair<int,pair<int,int>>> muchii; //cost, nod1, nod2
    for(int i=0;i<M;i++){
        int a,b,c;
        cin>>a>>b>>c;
        a--;b--;
        muchii.push({-c,{a,b}});
    }
    while(!muchii.empty()){
        int cost = -muchii.top().first, x = muchii.top().second.first, y =  muchii.top().second.second;

        muchii.pop();

        if(parinte[x]==-1){
            parinte[x]=x;
        }
        if(parinte[y]==-1){
            parinte[y]=y;
        }
        int px=find_parinte(x,parinte);
        int py=find_parinte(y,parinte);
        if(px!=py){
            conexe++;
            parinte[px]=py;
            if(cost<=A)
                platim+=cost;
            else{
                platim+=A;
                vindem+=cost;
            }
        }
        else{
            vindem+=cost;
        }
    }
    platim+=(N-conexe)*A;
    cout<<platim-vindem;
    return 0;
}

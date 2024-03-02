#pragma GCC optimize ("Ofast")
#include <iostream>
#include <bits/stdc++.h>

using namespace std;
int n,m;
vector<vector<int>> matrice(1000,vector<int>(1000));
int v1[4]={0,0,1,-1};
int v2[4]={1,-1,0,0};

void bfs(vector<int> v, vector<vector<int>> &graf, vector<int> &distante){
    queue<int> coada;
    for(int i=0;i<v.size();i++){
        coada.push(v[i]);
        distante[v[i]]=0;
    }
    while(!coada.empty()){
        int nod=coada.front();
        coada.pop();
        for(int i=0;i<graf[nod].size();i++){
            int vec=graf[nod][i];
            if(distante[vec]==-1){
                distante[vec]=distante[nod]+1;
                coada.push(vec);
            }
        }
    }
}

void bfs_insula(int start, vector<int> &insula, vector<vector<int>> &tip_copac, int id){
    queue<int> coada;
    coada.push(start);

    while(!coada.empty()){
        int nod=coada.front();
        coada.pop();
        insula[nod]=id;
        int l=nod/m,c=nod%m;

        for(int i=0;i<4;i++){
            if(l+v1[i]<n && l+v1[i]!=-1 && c+v2[i]<m &&c+v2[i]!=-1){
                int vec=(l+v1[i])*m+c+v2[i];
                if(insula[vec]==-1 && tip_copac[vec/m][vec%m]==tip_copac[nod/m][nod%m]){
                    insula[vec]=id;
                    coada.push(vec);
                }
            }
        }
    }
}

int main()
{
    freopen("padure.in","r",stdin);
    freopen("padure.out","w",stdout);
    int pl,pc,cl,cc;
    cin>>n>>m>>pl>>pc>>cl>>cc;
    pl--;pc--;cl--;cc--;
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            cin>>matrice[i][j];
        }
    }
    /*vector<vector<int>> graf(n*m);
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            if(j+1<m)
            {
                graf[i*m+j].push_back(i*m+1+j);
                graf[i*m+1+j].push_back(i*m+j);
            }
            if(i>0)
            {
                graf[i*m+j].push_back((i-1)*m+j);
                graf[(i-1)*m+j].push_back(i*m+j);
            }
        }
    }*/

    ///gasim insule de copaci la fel cu bfs
    vector<int>insula(n*m,-1);
    int id=-1;
    for(int i=0;i<n*m;i++){
        if(insula[i]==-1){
            //cout<<i<<" ";
            id++;
            bfs_insula(i,insula,matrice,id);
        }
    }
    id++;
    //cout<<id;
    ///construim un nou graf
    vector<vector<int>> grafNou(id);


    ///agaugam muchii in nou graf
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            int nod=i*m+j;
            for(int k=0;k<4;k++){
                if(i+v1[k]<n && i+v1[k]!=-1 && j+v2[k]<m &&j+v2[k]!=-1){
                    int vec=(i+v1[k])*m+j+v2[k];
                    if(matrice[vec/m][vec%m]!=matrice[i][j]){
                        grafNou[insula[i*m+j]].push_back(insula[vec]);
                        grafNou[insula[vec]].push_back(insula[i*m+j]);
                    }
                }
            }
        }
    }
    ///calculez distantele pe graful nou cu bfs
    vector<int> distante(id,-1);
    bfs(vector<int>(1,insula[pl*m+pc]),grafNou,distante);
    cout<<distante[insula[cl*m+cc]];
    return 0;
}

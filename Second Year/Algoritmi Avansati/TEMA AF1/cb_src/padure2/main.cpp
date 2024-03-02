#include <iostream>
#include <bits/stdc++.h>

using namespace std;

vector<vector<int>> matrice(1000,vector<int>(1000));
int INF=1e9;
int vizitat[10000005];
int v1[4]={0,0,1,-1};
int v2[4]={1,-1,0,0};


int main()
{
    freopen("padure.in","r",stdin);
    freopen("padure.out","w",stdout);
    int pl,pc,cl,cc,n,m;
    cin>>n>>m>>pl>>pc>>cl>>cc;
     vector<vector<pair<int,int>>> graf(n*m);
    pl--;pc--;cl--;cc--;
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            cin>>matrice[i][j];
        }
    }

    int distante[n*m+1];
    for(int i=0;i<n;i++){
        for(int j=0;j<m;j++){
            distante[i*m+j]=INF;
        }
    }
    //dijsktra
    distante[pl*m+pc]=0;
    //sursa = pl,pc

    for(int i=0;i<n*m;i++){
        //alegem urmatorul nod
        int nod,minn=INF;
        for(int v=0;v<n*m;v++){
            if(!vizitat[v] && distante[v]<minn){
                minn=distante[v];
                nod=v;
            }
        }
        vizitat[nod]=1;
        if(nod==cl*m+cc){
            cout<<distante[nod];
            break;
        }

        for(int k=0;k<4;k++){
            if(nod/m+v1[k]<n && nod/m+v1[k]!=-1 && nod%m+v2[k]<m &&nod%m+v2[k]!=-1){
                int vec= (nod/m+v1[k])*m+nod%m+v2[k];
                int d=0;

                if(matrice[nod/m][nod%m]!=matrice[vec/m][vec%m]){d=1;}
                if(!vizitat[vec] && distante[nod]+d<distante[vec]){
                    distante[vec]=distante[nod]+d;

                }
            }
        }

    }
    return 0;
}

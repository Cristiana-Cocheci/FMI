#include <iostream>
#include<bits/stdc++.h>

using namespace std;

int Cmmmc(int a, int b){
    int p=a*b;
    while(b!=0)
    {
        int r=a%b;
        a=b;
        b=r;
    }
    return p/a;
}

int main()
{
    freopen("patrol2.in","r",stdin);
    freopen("patrol2.out","w",stdout);
    int n,m,k;
    cin>>n>>m>>k;
    vector<vector<int>> graf(n), politisti(k);
    for(int i=0;i<m;i++){
        int a,b;
        cin>>a>>b;
        graf[a].push_back(b);
        graf[b].push_back(a);
    }
    ///construim matrice in care vedem daca la un timp %cmmmc(Li) un nod este liber
    int cmmmc=1;
    for(int i=0;i<k;i++){
        int l;
        cin>>l;
        politisti[i].push_back(l);
        cmmmc=Cmmmc(cmmmc,l);
        for(int j=0;j<l;j++){
            int x;
            cin>>x;
            politisti[i].push_back(x);

        }
    }
    //cout<<cmmmc<<"\n";
    int nod_ocupat[n][cmmmc];
    for(int i=0;i<n;i++){
        for(int j=0;j<cmmmc;j++){
            nod_ocupat[i][j]=0;
        }
    }
    /// actualizam matricea
    for(int pol=0;pol<k;pol++){
        int l=politisti[pol][0];
        for(int i=1;i<=l;i++){
            for(int k=0;k<cmmmc/l;k++){
                nod_ocupat[politisti[pol][i]][l*k+i-1]=1;
                //cout<<"nod_ocupat: "<<politisti[pol][i]<<" "<<l*k<<"\n";
            }
        }
    }
    /*for(int i=0;i<n;i++){
        for(int j=0;j<cmmmc;j++){
            cout<<nod_ocupat[i][j]<<" ";
        }
        cout<<"\n";
    }*/
    /// facem bfs pentru a face a doua matrice, matricea in care vedem
    /// timpul minim in care ajungi in celula respectiva

    int timp_minim[n][cmmmc];
    for(int i=0;i<n;i++){
        for(int j=0;j<cmmmc;j++){
            timp_minim[i][j]=-1;
        }
    }
    timp_minim[0][0]=0;
    queue<pair<int,int>> coada; //nod timp
    if(!nod_ocupat[0][0]){
        coada.push({0,0});
    }
    while(!coada.empty()){
        pair<int,int> nod_timp=coada.front();
        int nod=nod_timp.first;
        int timp=nod_timp.second;
        coada.pop();
        if(!nod_ocupat[nod][(timp+1)%cmmmc] && timp_minim[nod][(timp+1)%cmmmc]==-1){
            timp_minim[nod][(timp+1)%cmmmc]=timp_minim[nod][timp]+1;
            coada.push(make_pair(nod,(timp+1)%cmmmc));
        }
        for(int i=0;i<graf[nod].size();i++){
            int vec=graf[nod][i];
            if(!nod_ocupat[vec][(timp+1)%cmmmc] && timp_minim[vec][(timp+1)%cmmmc]==-1)
            {
                coada.push(make_pair(vec,(timp+1)%cmmmc));
                timp_minim[vec][(timp+1)%cmmmc]=timp_minim[nod][timp]+1;
            }
        }
    }
    int timp=100000000;


    for(int i=0;i<cmmmc;i++){
        if(timp_minim[n-1][i]!=-1 && timp_minim[n-1][i]<timp){
            timp=timp_minim[n-1][i];
        }
    }
    if(timp!=100000000)
        cout<<timp;
    else
        cout<<"-1";
    return 0;
}

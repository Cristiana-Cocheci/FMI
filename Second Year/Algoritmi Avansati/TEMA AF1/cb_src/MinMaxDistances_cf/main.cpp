#include <iostream>
#include<bits/stdc++.h>

using namespace std;

void bfsDistante(int nod, vector<vector<int>> &graf, vector<int> &distante){
    queue<int> coada;

    coada.push(nod);
    distante[nod]=0;

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

int main()
{
    //freopen("intro.in","r",stdin);
    //freopen("out.out","w",stdout);
    int t;
    cin>>t;
    for(int q=0;q<t;q++){
        int n,k;
        cin>>n>>k;
        vector<bool> rosii(n+1,0);
        for(int i=0;i<k;i++){
            int x;
            cin>>x;
            rosii[x]=1;
        }
        vector<vector<int>> graf(n+1);
        for(int i=1;i<n;i++){
            int x,y;
            cin>>x>>y;
            graf[y].push_back(x);
            graf[x].push_back(y);
        }

        ///facem diametrul doar cu nodurile rosii
        vector<int> distante(n+1);
        for(int i=1;i<=n;i++){
            distante[i]=-1;
        }

        //bfs care returneaza cel mai departat nod de radacina aleasa
        bfsDistante(1,graf,distante);
        int max_dist=-1;
        int nod_rosu_indepartat1;
        for(int i=1;i<=n;i++){
            if(distante[i]>max_dist && rosii[i]==1){
                nod_rosu_indepartat1=i;
                max_dist=distante[i];
            }
        }

         vector<int> distante1(n+1,-1),distante2(n+1,-1);
        //bfs ca sa gasim celalalt cel mai indepartat nod
        bfsDistante(nod_rosu_indepartat1,graf,distante1);
        max_dist=-1;
        int nod_rosu_indepartat2;
        for(int i=1;i<=n;i++){

            if(distante1[i]>max_dist && rosii[i]==1){
                nod_rosu_indepartat2=i;
                 max_dist=distante1[i];
            }
        }
        //cout<<"\n"<<nod_rosu_indepartat1<<" "<<nod_rosu_indepartat2<<"\n";

        //calculam distantele de la cele doua noduri extrema la fiecare nod

        //bfsDistante(nod_rosu_departat1,graf,distante1);
        bfsDistante(nod_rosu_indepartat2,graf,distante2);
        int minim=1000000;
        for(int i=1;i<=n;i++){
            int dist_max_pentru_i=max(distante1[i],distante2[i]);
            if(minim>dist_max_pentru_i){
                minim=dist_max_pentru_i;
            }
        }

        cout<<minim<<"\n";
    }
    return 0;
}

/*

*/

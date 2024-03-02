#include <iostream>
#include <bits/stdc++.h>
#include <limits>

using namespace std;

#define INF numeric_limits<double>::infinity()
int n;
double suma=0;
vector<pair<int,int>> noduri;
vector<double> distante; //distanta minima


double dist_i_j(int xi,int yi, int xj, int yj){
    return sqrt((xi-xj)*(xi-xj)+(yi-yj)*(yi-yj));
}


int main()
{
    freopen("cablaj.in","r",stdin);
    freopen("cablaj.out","w",stdout);
    scanf("%d",&n);
    vector<bool> vizitat(n,0);
    int x,y;
    cin>>x>>y;
    noduri.push_back({x,y});
    distante.push_back(0);
    for(int i=1;i<n;i++){
        int x,y;
        cin>>x>>y;
        noduri.push_back({x,y});
        distante.push_back(INF);
    }
    int nod_curent=0;

    for(int i=0;i<n-1;i++){
        vizitat[nod_curent]=1;
        double min_nod,min_dist=INF;
        for(int j=0;j<n;j++){
            if(!vizitat[j]){
                double distanta_curenta=distante[j];
                double distanta_noua= dist_i_j(noduri[nod_curent].first,noduri[nod_curent].second,noduri[j].first,noduri[j].second);
                if(distanta_noua<distanta_curenta){
                    distante[j]=distanta_noua;
                }
                if(distante[j]<min_dist){
                    min_dist=distante[j];
                    min_nod=j;
                }
            }
        }
        nod_curent=min_nod;
        //printf("%lf ",min_dist);
        suma+=min_dist;
        //printf("%lf\n",suma);
    }
    printf("%.4lf",suma);
    return 0;
}

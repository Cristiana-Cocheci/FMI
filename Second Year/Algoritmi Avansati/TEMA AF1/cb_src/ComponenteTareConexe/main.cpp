#include <iostream>
#include <bits/stdc++.h>

using namespace std;

void dfs(int nod,vector<vector<int>>& graf, stack<int> &prioritati, vector<int> &vizitat){
    vizitat[nod]=1;
    for(int i=0;i<graf[nod].size();i++){
        int vec=graf[nod][i];
        if(!vizitat[vec]){
            dfs(vec,graf,prioritati,vizitat);
        }
    }
    prioritati.push(nod);
}
void dfs2(int nod,vector<vector<int>> &inverted, vector<int> &vizitat, int id, bool& b, vector<bool>& nf)
{
    vizitat[nod]=id;
    if(nf[nod]){b=1;}
    for(int i=0;i<inverted[nod].size();i++){
        int vec=inverted[nod][i];
        if(!vizitat[vec]){
            dfs2(vec,inverted,vizitat,id,b,nf);
        }
    }
}

vector<vector<int>> componente_tare_conexe(vector<vector<int>>&graph){
    vector<vector<int>> inverted(graph.size());
    vector<bool> nod_final(graph.size(),0);
    //inversam graful
    for(int i=0;i<graph.size();i++){

        if(graph[i].size()==0){
            nod_final[i]=1;
        }
        for(int j=0;j<graph[i].size();j++){
            inverted[graph[i][j]].push_back(i);
        }
    }

    //dfs with vertex  priorities
    stack<int> prioritati;
    vector<int> vizitat(graph.size(),0);
    for(int i=0;i<graph.size();i++){
        if(!vizitat[i]){
            dfs(0,graph,prioritati,vizitat);
        }
    }
    //clear visited
    for(int k=0;k<graph.size();k++){
        vizitat[k]=0;
    }
    //parcurgere invers
    int id_componenta=1;
    ///algoritmul lui  kosaraju

    vector<bool> contine_nod_final(1,0);
    while(!prioritati.empty()){
        int nod=prioritati.top();
        prioritati.pop();
        bool are_nod_final=0;
        if(!vizitat[nod])
        {
            dfs2(nod,inverted,vizitat,id_componenta,are_nod_final,nod_final);

            //avem o componenta cu id_componenta in vizitat
            contine_nod_final.push_back(are_nod_final);
            id_componenta++;
        }
    }
    vector<vector<int>>multimi_componente(id_componenta);
    for(int i=0;i<graph.size();i++){
        cout<<i<<" "<<vizitat[i]<<"\n";
        multimi_componente[vizitat[i]].push_back(i);
    }
    return multimi_componente;
}

int main()
{
    int n;
    cin>>n;
    vector<vector<int>> graph(n);
    for(int i=0;i<n;i++){
        int x;
        cin>>x;
        for(int j=0;j<x;j++){
            int a;
            cin>>a;
            graph[i].push_back(a);
        }
    }


    vector<vector<int>>componente_conexe;
    componente_conexe=componente_tare_conexe(graph);


    return 0;
}

/*
8
1
1
3
2 3 4
2
0 3
0
2
5 6
1
7
1
5
1
6

0 1
1 1
2 1
3 8
4 3
5 4
6 4
7 4
*/

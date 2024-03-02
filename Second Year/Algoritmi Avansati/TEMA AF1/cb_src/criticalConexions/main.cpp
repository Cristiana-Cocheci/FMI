#include <iostream>
#include <bits/stdc++.h>

using namespace std;

void dfs(int nod, vector<vector<int>>&graf, vector<vector<int> >&criticalConections, vector<int> &vizitat, vector<int> &nivel, vector<int> &nivMin){
    vizitat[nod]=1;
    nivMin[nod]=nivel[nod];
    for(int i=0;i<graf[nod].size();i++){
        int vec=graf[nod][i];
        if(!vizitat[vec]){
            nivel[vec] = nivel[nod]+1;
            dfs(vec,graf,criticalConections,vizitat,nivel,nivMin);
            // actualizare nivel minim nod
            nivMin[nod] = min(nivMin[nod], nivMin[vec]);
            if(nivMin[vec]>nivel[nod]){
                vector<int> t(2);
                t[0]=nod;
                t[1]=vec;
                criticalConections.push_back(t);
            }
        }
        else{
            //daca avem muchie de intoarcere
            if(nivel[vec]< nivel[nod]-1){
                nivMin[nod]= min(nivMin[nod], nivel[vec]);
            }
        }
    }

}

int main()
{
    int n,con;
    cin>>n>>con;
    vector<vector<int>> connections;
    for(int i=0;i<con;i++){
        vector<int> t(2);
        cin>>t[0]>>t[1];
        connections.push_back(t);
    }

    //facem listele de adiacenta
    vector<vector<int>> graf(n);
    for(int i=0;i<connections.size();i++){
        int x=connections[i][0], y=connections[i][1];
        graf[x].push_back(y);
        graf[y].push_back(x);
    }
    vector<vector<int>> criticalConections;
    vector<int> vizitat(n,0), nivel(n,n+1), nivelMin(n,n+1);
    nivel[0]=1;
    dfs(0,graf,criticalConections,vizitat,nivel,nivelMin);
    //cout<<criticalConections.size();
    for(int i=0;i<criticalConections.size();i++){
        cout<<criticalConections[i][0]<<" "<<criticalConections[i][1]<<"\n";
    }
    return 0;
}

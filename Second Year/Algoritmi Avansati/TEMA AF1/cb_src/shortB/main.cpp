#include <iostream>
#include <bits/stdc++.h>

using namespace std;

void dfs_insula(int nod, vector<vector<int>> &graf, vector<int> &vizitat, int id, vector<vector<int>> &grid, vector<int> &c1){
    vizitat[nod]=id;
    c1.push_back(nod);

    for(int i=0;i<graf[nod].size();i++){
        int vec=graf[nod][i];
        if(vizitat[vec]==-1 && grid[vec/graf.size()][vec%graf.size()]==1){
            dfs_insula(vec, graf,vizitat,id,grid,c1);
        }
    }
}

void bfs(vector<int> &v, vector<vector<int>> &graf, vector<int> &distante){
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

int main()
{
    // freopen64("data.in", "r", stdin);
    int n;
    cin>>n;
    vector<vector<int>> grid;
    for(int i=0;i<n;i++) {
        vector<int> t(n);
        for(int j=0;j<n;j++){
            cin>>t[j];
        }
        grid.push_back(t);
    }

    n=grid.size();
    vector<vector<int>> graf(n*n);

    int i1=-1,j1=-1;
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            if(grid[i][j]==1 && i1!=-1){
                i1=i;j1=j;
            }
            if(j+1<n)
            {
                graf[i*n+j].push_back(i*n+1+j);
                graf[i*n+1+j].push_back(i*n+j);
            }
            if(i>0)
            {
                graf[i*n+j].push_back((i-1)*n+j);
                graf[(i-1)*n+j].push_back(i*n+j);
            }
        }

    }
    ///componenta 1;
    int nod=i1*n+j1,nod2;
    vector<int> distante(n*n,-1);
    vector<int> c1,c2,vizitat(n*n,-1);
    dfs_insula(nod, graf, vizitat, 0, grid, c1);
    for(int k=0;k<n*n;k++){
        int i=k/n, j=k%n;
        if(vizitat[k]==-1 && grid[i][j]==1){
            nod2=k;
            break;
        }
    }
    dfs_insula(nod2,graf,vizitat, 1, grid, c2);

    ///bfs pe prima componenta conexa
    bfs(c1,graf,distante);
    ///minimul de distanta din c2
    int minim=n*n;
    for(int i=0;i<c2.size();i++){
        minim=min(minim,distante[c2[i]]);
    }
    cout<<minim -1 << "\n";
    return 0;
}

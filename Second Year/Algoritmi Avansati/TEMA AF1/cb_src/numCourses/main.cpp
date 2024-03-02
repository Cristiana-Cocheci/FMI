#include <iostream>
#include <bits/stdc++.h>

using namespace std;

bool cicluu(vector<vector<int>> graf, vector<bool>visited, int nod){
    if(visited[nod]==true)
        return true;
    visited[nod]=1;
    bool ciclu=0;
    for(int i=0;i<graf[nod].size();i++){
        ciclu= cicluu(graf,visited,graf[nod][i]);
        if(ciclu){
            return 1;
        }
    }
    return 0;
}

bool ciclu(int n, vector<vector<int>> graf){
    vector<bool> visited(n,0);
    bool ciclu=0;
    for(int i=0;i<n;i++){
        visited[i]=1;
        for(int j=0;j<graf[i].size();j++){
            ciclu = cicluu(graf, visited, graf[i][j]);
            if(ciclu){
                return 1;
            }
        }
        visited[i]=0;
    }
    return 0;
}

int main()
{
    vector<vector<int>> prereqisites;
    int numCourses, n;
    cin>>numCourses>>n;
    for(int i=0;i<n;i++){
        vector<int> t(2);
        int x,y;
        cin>>x>>y;
        t[0]=x;
        t[1]=y;
        prereqisites.push_back(t);
    }
    vector<vector<int>> graf(numCourses);
    vector<int> rezultat;
    queue<int> coada;
    int grad_interior[numCourses],vizitat[numCourses],dfs_vizitat[numCourses];
    for(int i=0;i<numCourses;i++){
        grad_interior[i]=0;
        vizitat[i]=0;
        dfs_vizitat[i]=0;
    }
    for(int i=0;i<prereqisites.size();i++){
        graf[prereqisites[i][1]].push_back(prereqisites[i][0]);
        grad_interior[prereqisites[i][0]]++;
    }

    //verific daca are ciclu
    bool are_ciclu=ciclu(numCourses, graf);


    if(!are_ciclu){
        for(int i=0;i<numCourses;i++){
            if(grad_interior[i]==0){
                coada.push(i);
                vizitat[i]=1;
            }
        }
        while(coada.empty()==0){
            int nod=coada.front();
            rezultat.push_back(nod);
            coada.pop();
            //scadem gradele vecinilor luinod
            for(int i=0;i<graf[nod].size();i++){
                grad_interior[graf[nod][i]]--;
                //adaugam in coada noi candidati
                if(vizitat[graf[nod][i]]==0 && grad_interior[graf[nod][i]]==0){
                    vizitat[graf[nod][i]]=1;
                    coada.push(graf[nod][i]);
                }
            }

        }

    }

    //afisare graf
    /*for(int i=0;i<numCourses;i++){
        cout<<i<<": ";
        for(int j=0;j<graf[i].size();j++){
            cout<<graf[i][j];
        }
        cout<<endl;
    }*/
    cout<<are_ciclu<<"\n";
    for(int i=0;i<rezultat.size();i++){
            cout<<rezultat[i]<<" ";
        }


    return 0;
}

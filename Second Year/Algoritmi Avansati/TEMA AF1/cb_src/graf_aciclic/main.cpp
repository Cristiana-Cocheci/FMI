#include <iostream>
#include <bits/stdc++.h>

using namespace std;

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
    stack<int> stiva;
    int dfs_vizitat[numCourses];
    for(int i=0;i<numCourses;i++){
        dfs_vizitat[i]=0;
    }
    for(int i=0;i<prereqisites.size();i++){
        graf[prereqisites[i][1]].push_back(prereqisites[i][0]);

    }

    //verific daca are ciclu
    bool are_ciclu=0;
    for(int i=0;i<numCourses;i++){
        if(!dfs_vizitat[i])
            stiva.push(i);
            dfs_vizitat[i]=1;
        }
        while(!stiva.empty()){
            if(dfs_vizitat[stiva.top()]){
                are_ciclu=1;
            }
            for(int j=0;j<graf[stiva.top()].size();j++){
                if(!dfs_vizitat[graf[stiva.top()][j]]){
                    stiva.push(graf[stiva.top()][j]);
                    dfs_vizitat[graf[stiva.top()][j]]=1;
                }
            }

            stiva.pop();
        }

    cout<<are_ciclu;
    return 0;
}

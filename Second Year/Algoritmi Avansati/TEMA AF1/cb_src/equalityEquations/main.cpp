#include <iostream>
#include <bits/stdc++.h>

using namespace std;

int main()
{
    int e, n=26;
    cin>>e;
    vector<string> equations;
    for(int i=0;i<e;i++){
        string t;
        cin>>t;
        equations.push_back(t);
    }

    vector<vector<int>> graf(26);
    vector<vector<int>> queries;
    for(int i=0;i<equations.size();i++){
        string t=equations[i];
        int a=t[0]-'a', b=t[3]-'a';
        //cout<<t[0]<<" "<<b<<"\n";
        if(t[1]=='='){
            graf[a].push_back(b);
            graf[b].push_back(a);
        }
        else{
            vector<int> aux(2);
            aux[0]=a;
            aux[1]=b;
            queries.push_back(aux);
        }
    }
    /*for(int i=0;i<26;i++){
        for(int j=0;j<graf[i].size();j++){
            cout<<graf[i][j]<<" ";
        }
        cout<<"\n";
    }*/


    vector<int> componenta(26,-1);
    int k=0;
    for(int i=0;i<26;i++){
        if(componenta[i]==-1){
            //facem bfs
            queue<int> coada;
            coada.push(i);
            while(!coada.empty()){
                int nod=coada.front();
                componenta[nod]=k;
                for(int j=0;j<graf[nod].size();j++){
                    if(componenta[graf[nod][j]]==-1)
                        coada.push(graf[nod][j]);
                }
                coada.pop();
            }
            //urmatoarea componenta
            k++;
        }
        //cout<<i<<" "<<componenta[i]<<"\n";
    }
    bool posibil=1;
    for(int i=0;i<queries.size() && posibil;i++){
        if(componenta[queries[i][0]]==componenta[queries[i][1]]){
            posibil=0;
        }
    }
    cout<<posibil;
    return 0;
}

/*
2
"a==b"
"b!=a"
*/

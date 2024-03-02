#include <iostream>
#include <bits/stdc++.h>

using namespace std;

int main()
{
    int n, x;
    vector<vector<int>> dislikes;
    cin>>n>>x;
    for(int i=0;i<x;i++){
        vector<int> t(2);
        cin>>t[0]>>t[1];
        t[0]--;
        t[1]--;
        dislikes.push_back(t);
    }

    vector<vector<int>> graf(n);
    for(int i=0;i<dislikes.size();i++){
        graf[dislikes[i][0]].push_back(dislikes[i][1]);
        //cout<<dislikes[i][0]<<" "<<dislikes[i][1]<<"\n";
    }

    //colorare
    vector<int> colorare(n,0);
    //parcurgere
    queue<int> coada;
    bool bipartit=1;
    for(int i=0;i<n && bipartit;i++){
        if(colorare[i]==0){//daca nu e vizitat nodul

            coada.push(i);
            colorare[i]=-1;

            while (!coada.empty() && bipartit){
                int nod=coada.front();
                coada.pop();
                for(int j=0;j<graf[nod].size();j++){
                    int vec=graf[nod][j];
                    if(colorare[vec]==0){//verificam daca vecinul a fost colorat deja
                        colorare[vec]=-colorare[nod];
                        coada.push(vec);
                    }
                    else{
                        if(colorare[vec]==colorare[nod]){
                            bipartit=0;
                            break;
                        }
                    }
                }
            }
        }
    }
    cout<<bipartit;
    return 0;
}

/*
facem bfs, pe parcurs coloram nodurile
coloram un nod-ii coloram tori vecinii si ii bagam in coada
*/

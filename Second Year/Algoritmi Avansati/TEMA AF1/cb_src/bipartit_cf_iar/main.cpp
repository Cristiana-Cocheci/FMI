#include <iostream>
#include <bits/stdc++.h>

using namespace std;


vector<int> bipartit(vector<vector<int>> &graf) {
    int n=graf.size()-1;
    bool bipartit=true;
    //colorare
    vector<int> colorare(n+2,0);
    //parcurgere
    queue<int> coada;
    for(int i=1;i<=n;i++){
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
                            bipartit=false;
                            break;
                        }
                    }
                }
            }
        }
    }
    colorare[n+1]=(bipartit);
    return colorare;
}


int main()
{
    int n,m;
    cin>>n>>m;
    vector<vector<int>> graf(n+1), edges;
    for(int i=0;i<m;i++){
        vector<int> t(2);
        cin>>t[0]>>t[1];
        edges.push_back(t);
        graf[t[0]].push_back(t[1]);
        graf[t[1]].push_back(t[0]);
    }
    vector<int> colorare=bipartit(graf);
    if(colorare[n+1]==0){
        cout<<"NO";
    }
    else{
        cout<<"YES\n";
        for(int i=0;i<m;i++){
            if(colorare[edges[i][0]]==1){
                cout<<0;
                //rezultat.push_back(0);
            }
            else{
                cout<<1;
                //rezultat.push_back(1);
            }
        }

    }

    return 0;
}

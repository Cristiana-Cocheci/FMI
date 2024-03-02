#include <iostream>
#include <bits/stdc++.h>

using namespace std;

int main()
{
    freopen("semne3.in","r",stdin);
    freopen("semne3.out","w",stdout);
    int n;
    cin>>n;
    vector<vector<int>> graf(n+1);
    vector<int> grad_interior(n+1),vizitat(n+1);
    queue<int> coada;
    for(int i=1;i<=n;i++){
        char semn;
        cin>>semn;
        if(semn=='>'){
            graf[i+1].push_back(i);
            grad_interior[i]++;
        }
        else{
            graf[i].push_back(i+1);
            grad_interior[i+1]++;
        }
    }
    for(int i=1;i<=n;i++){
        if(grad_interior[i]==0){
            vizitat[i]++;
            cout<<i<<" ";
            coada.push(i);
        }
    }
    while(coada.empty()==0){
        cout<<endl<<coada.front()<<" ";
        int x=coada.front();
        for(int i=0;i<graf[x].size();i++){
            //cout<<graf[x][i]<<" ";
            grad_interior[graf[x][i]]--;

        }
        for(int i=1;i<=n;i++){
                if(grad_interior[i]==0 && vizitat[i]==0){
                    coada.push(i);
                    vizitat[i]=1;
                }
        }
        coada.pop();
    }
    return 0;
}

/*
1<-2
2->3
3<-4
*/

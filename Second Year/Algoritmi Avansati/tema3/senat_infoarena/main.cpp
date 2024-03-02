#include <stdio.h>
#include <bits/stdc++.h>
#define NMAX 1005
#define MMAX 400005

using namespace std;

vector<vector<pair<int,int>>> capacitate;
int src, dest;
vector<int> level;
int N, flow_rezultat=0; //N e numarul de noduri


bool bfs(){
    queue<int> coada;
    bool ok = 0;

    for(int i=0;i<N; i++){
        level[i] = N;
    }
    level[src] = 0;
    coada.push(src);

    while(!coada.empty()){
        int nod = coada.front();
        coada.pop();

        for(int i=0; i<capacitate[nod].size(); i++){
            int vec = capacitate[nod][i].first;
            //cout<< nod<<" "<<vec<<" "<< capacitate[nod][i].second<<" "<<level[vec]<<" "<<level[nod]+1<<"\n";
            if(capacitate[nod][i].second && level[vec] > level[nod]+1){
                if(vec == dest){
                    ok=1; //am ajuns la destinatie
                }
                else{
                    level[vec] = level[nod]+1;
                    coada.push(vec);
                }
            }
        }
    }
    return ok;
}

int dfs(int nod, int bottleneck){
    if(!bottleneck){
        return 0;
    }

    if(nod == dest){

        //cout<< "b: "<<bottleneck<<"\n";
        return bottleneck;
    }
    int maxflow = bottleneck;
    for(int i=0; i<capacitate[nod].size();i++){
        int vec = capacitate[nod][i].first;
        if(capacitate[nod][i].second && level[vec] > level[nod]){
            //cout<< nod<< " "<< vec<<" "<<capacitate[nod][i].second<<"\n";
            int flow_nou = dfs(vec, min(bottleneck, capacitate[nod][i].second));
            bottleneck -= flow_nou;
            capacitate[nod][i].second-= flow_nou;
            for(int j =0;j<capacitate[vec].size();j++){
                if(capacitate[vec][j].first == nod){
                    capacitate[vec][j].second += flow_nou;
                    break;
                }
            }
        }
    }
    return maxflow - bottleneck;
}

bool dinic(){
    bool ok = 0;
    if(!bfs()){
        return 0;
        //nu se poate ajunge din src la dest pe graf
    }
    int aux = dfs(src, 1);
    flow_rezultat += aux;
    //cout<<aux<<"\n";
    while(aux)
    {
        ok=1;
        aux = dfs(src, 1);
        //cout<<aux<<"\n";
        flow_rezultat += aux;
    }
    return ok;
}

int main(){
    freopen("senat.in","r",stdin);
    freopen("senat.out","w",stdout);
    int Ns, Nc;
    cin>>Ns>>Nc;

    if(Ns < Nc){
        cout<<0;
        return 0;
    }

    N = Ns+Nc+ 2;
    src = Ns+Nc;
    dest = N - 1;
    level.resize(N,0);
    capacitate.resize(N);
    // 0..Ns-1 == senatori
    // Ns..Ns+Nc-1 == comisii

    std::string line;

    for (int i = Ns; i <= Ns+Nc; i++) {
        std::getline(std::cin, line);
        // Create a stringstream from the line
        std::istringstream iss(line);
        int num;
        // Read numbers from the stringstream
        while (iss >> num) {
            num--;
            capacitate[num].push_back({i-1,1});
            capacitate[i-1].push_back({num,0});
        }
    }
    for(int i=0;i<Ns+Nc;i++){
        if(i<Ns){
            capacitate[src].push_back({i,1});
            capacitate[i].push_back({src,0});
        }
        else{
            capacitate[i].push_back({dest,1});
            capacitate[dest].push_back({i,0});
        }
    }


    /*for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }*/

    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);
    if(flow_rezultat == Nc){
        for(int i=Ns; i<Ns+Nc; i++){
            for(int j=0; j<capacitate[i].size();j++){
                if(capacitate[i][j].second == 1 && capacitate[i][j].first <Ns){
                cout<<capacitate[i][j].first+1<<"\n";
            }
            }
        }

    }
    else{
        cout<<0;
    }

    /*cout<<"\n";
    for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }*/
    return 0;
}

#include <bits/stdc++.h>
//'A'..'Z' == 0..25
//'a'..'z' == 26..51
//nod = nod-'A' sau nod-'a'+26

using namespace std;
vector<char> rezultat;
vector<vector<pair<int,int>>> capacitate;
int src, dest;
vector<int> level;
vector<bool> mincut;
int N, flow_rezultat=0; //N e numarul de noduri
int INF =1000;


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
int main()
{
    freopen("paznici.in","r",stdin);
    freopen("paznici.out","w",stdout);
    int Nl, M;
    cin>>Nl>>M;
    N=Nl+M+2;
    src = N-2;
    dest= N-1;
    level.resize(N,0);
    mincut.resize(N,0);
    capacitate.resize(N);
    for(int i=0; i<Nl;i++){
        string linie;
        cin>> linie;
        for(int j = 0; j < M; j++)
        {
            if(linie[j] == '1')
            {
                if(linie[j]=='1'){

                int x,y;
                x=i;
                y=j+Nl;
                //cout<<x<<" "<<y<<"\n";
                capacitate[x].push_back({y,INF});
                capacitate[y].push_back({x,0});
                }
            }
        }
    }

    for(int i=0; i<Nl; i++){
        capacitate[src].push_back({i,1});
        capacitate[i].push_back({src,0});
    }
    for(int i=Nl;i<M+Nl;i++){
        capacitate[i].push_back({dest,1});
        capacitate[dest].push_back({i,0});
    }
    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);
    /*cout<<"\n";
    for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }*/
    mincut[src]=1;
    queue<int> coada;
    for(int i=0;i<capacitate[src].size();i++){
        if(capacitate[src][i].second>0){

                coada.push(capacitate[src][i].first);
        }
    }
    //bfs din src pentru aflarea celor doua submultimi
    while(!coada.empty()){
        int nod = coada.front();
        mincut[nod]=1;
        //cout<<nod<<" ";
        coada.pop();
        for(int i=0;i<capacitate[nod].size();i++){
            if(capacitate[nod][i].second>0 && mincut[capacitate[nod][i].first]==0){
                coada.push(capacitate[nod][i].first);

            }
        }
    }

    for(int i=0; i<N-2; i++){
        //cout<<i<<" "<<mincut[i]<<"\n";
        if(!mincut[i] && i<Nl){
            rezultat.push_back((char) (i+'A'));
        }
        if(mincut[i] && i>=Nl){
            rezultat.push_back((char)(i+'a'-Nl));
        }
    }
    for(auto x : rezultat){
        cout<<x;
    }

    //cout<<flow_rezultat;
    return 0;
}
/*
int main()
{
    freopen("paznici.in","r",stdin);
    freopen("paznici.out","w",stdout);
    int Nl, M;
    cin>>Nl>>M;
    N=Nl+M+2;
    src = N-2;
    dest= N-1;
    level.resize(N,0);
    mincut.resize(N,0);
    capacitate.resize(N);
    for(int i=0; i<Nl;i++){
        string linie;
        cin>> linie;
        for(int j = 0; j < M; j++)
        {
            if(linie[j] == '1')
            {
                if(linie[j]=='1'){

                int x,y;
                x=i;
                y=j+Nl;
                //cout<<x<<" "<<y<<"\n";
                capacitate[x].push_back({y,1});
                capacitate[y].push_back({x,0});
                }
            }
        }
    }

    for(int i=0; i<Nl; i++){
        capacitate[src].push_back({i,27});
        capacitate[i].push_back({src,0});
    }
    for(int i=Nl;i<M+Nl;i++){
        capacitate[i].push_back({dest,1});
        capacitate[dest].push_back({i,0});
    }
    bool ok;
    do{
        ok = dinic();
    }
    while(ok==1);
    cout<<"\n";
    for(int i=0;i<capacitate.size();i++){
        for(int j=0; j<capacitate[i].size();j++){
            cout<<i<<" "<<capacitate[i][j].first<<" "<<" c: "<<capacitate[i][j].second<<"\n";
        }
    }
    mincut[src]=1;
    queue<int> coada;
    for(int i=0;i<capacitate[src].size();i++){
        if(capacitate[src][i].second>0){

                coada.push(capacitate[src][i].first);
            if(capacitate[src][i].first<Nl){
                rezultat.push_back((char) (capacitate[src][i].first+'A'));
            }
        }
    }
    //bfs din src pentru aflarea celor doua submultimi
    while(!coada.empty()){
        int nod = coada.front();
        mincut[nod]=1;
        cout<<nod<<" ";
        coada.pop();
        for(int i=0;i<capacitate[nod].size();i++){
            if(capacitate[nod][i].second>0 && mincut[capacitate[nod][i].first]==0){
                coada.push(capacitate[nod][i].first);

            }
        }
    }

    for(int i=0; i<N; i++){
        cout<<i<<" "<<mincut[i]<<"\n";
        if(mincut[i]){
            for(int j=0;j<capacitate[i].size();j++){
                if(mincut[capacitate[i][j].first]==0){
                    cout<<i<<" - "<<capacitate[i][j].first<<"\n";
                }
            }
        }
    }


    //cout<<rezultat;
    return 0;
}
*/

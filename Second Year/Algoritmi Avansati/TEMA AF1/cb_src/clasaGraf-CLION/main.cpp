#include <iostream>
#include <bits/stdc++.h>

using namespace std;

class Graf{
private:
    bool orientat;
    int n;
    vector<vector<int>> muchii;
    vector<vector<int>> graf;
public:
    Graf(bool _orientat=0, int _n=0,vector<vector<int>> _muchii = vector<vector<int>>(),
         vector<vector<int>> _graf= vector<vector<int>>())
    : orientat(_orientat), n(_n), muchii(_muchii), graf(_graf){}
    Graf(vector<vector<int>> g):graf(g){
        orientat=0;
        n=g.size();
        muchii=vector<vector<int>>();
    }
    Graf(int _n,vector<vector<int>>_muchii): n(_n), muchii(_muchii)
    {
            graf=vector<vector<int>>(_n);
            for(int i=0;i<_muchii.size();i++){
                int a=_muchii[i][0], b=_muchii[i][1];
                graf[a].push_back(b);
                if(!orientat){
                    graf[b].push_back(a);
                }
            }

    }
    void afisare();
    vector<int> gradInterior();
    vector<vector<int>> InvertGraf();
    vector<int> bipartit();
    vector<vector<int>> muchiiCritice();
    void dfs_crit(int nod, vector<vector<int>>&criticalConections, vector<int> &vizitat, vector<int> &nivel, vector<int> &nivMin);
    vector<int> sortare_topologica(bool partial=0);
    vector<vector<int>> componente_tare_conexe();
    void dfs_prioritati(int nod, stack<int> &prioritati, vector<int> &vizitat);
    void dfs2_inverted(int nod,vector<vector<int>> &inverted, vector<int> &vizitat, int id, bool& b, vector<bool>& nf);

};

vector<int> Graf::bipartit() {
    bool bipartit=true;
    //colorare
    vector<int> colorare(n+2,0);
    //parcurgere
    queue<int> coada;
    for(int i=1;i<=n;i++){
        if(colorare[i]==0){//daca nu e vizitat nodul
            coada.push(i);
            colorare[i]=-1;
            while (!coada.empty()){
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
    colorare.push_back(bipartit);
    return colorare;
}

vector<vector<int>> Graf::muchiiCritice() {
    vector<vector<int>> criticalCons;
    vector<int> vizitat(n,0), nivel(n,n+1), nivelMin(n,n+1);
    nivel[0]=1;
    dfs_crit(0,criticalCons,vizitat,nivel,nivelMin);
    return criticalCons;
}

void Graf::dfs_crit(int nod, vector<vector<int>> &criticalConections, vector<int> &vizitat,
               vector<int> &nivel, vector<int> &nivMin) {
    vizitat[nod]=1;
    nivMin[nod]=nivel[nod];
    for(int i=0;i<graf[nod].size();i++){
        int vec=graf[nod][i];
        if(!vizitat[vec]){
            nivel[vec] = nivel[nod]+1;
            dfs_crit(vec,criticalConections,vizitat,nivel,nivMin);
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

vector<int> Graf::sortare_topologica(bool partial) {
    vector<int> rezultat;
    queue<int> coada;
    int vizitat[n],dfs_vizitat[n];
    vector<int> grad_interior(n);
    for(int i=0;i<n;i++){
        grad_interior[i]=0;
        vizitat[i]=0;
        dfs_vizitat[i]=0;
    }
    grad_interior=gradInterior();

    for(int i=0;i<n;i++){
        if(grad_interior[i]==0){
            coada.push(i);
            vizitat[i]=1;
        }
    }
    bool ciclu=0;
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
    if(rezultat.size()<n && partial==1){
        return vector<int>();
    }

    return rezultat;
}

vector<int> Graf::gradInterior() {
    vector<int> grade(n,0);
    for(int i=0;i<n;i++){
        for(int j=0;j<graf[i].size();j++){
            grade[graf[i][j]]++;
        }
    }
    return grade;
}

vector<vector<int>> Graf::componente_tare_conexe() {
    vector<vector<int>> inverted=InvertGraf();
    vector<bool> nod_final(graf.size(),0);
    //inversam graful
    /*for(int i=0;i<graf.size();i++){

        if(graf[i].size()==0){
            nod_final[i]=1;
        }
        for(int j=0;j<graf[i].size();j++){
            inverted[graf[i][j]].push_back(i);
        }
    }*/

    //dfs with vertex  priorities
    stack<int> prioritati;
    vector<int> vizitat(graf.size(),0);
    for(int i=0;i<graf.size();i++){
        if(!vizitat[i]){
            dfs_prioritati(0,prioritati,vizitat);
        }
    }
    //clear visited
    for(int k=0;k<graf.size();k++){
        vizitat[k]=0;
    }
    //parcurgere invers
    int id_componenta=1;
    ///algoritmul lui  kosaaraju

    vector<bool> contine_nod_final(1,0);
    while(!prioritati.empty()){
        int nod=prioritati.top();
        prioritati.pop();
        bool are_nod_final=0;
        if(!vizitat[nod])
        {
            dfs2_inverted(nod,inverted,vizitat,id_componenta,are_nod_final,nod_final);
            //avem o componenta cu id_componenta in vizitat
            contine_nod_final.push_back(are_nod_final);
            id_componenta++;
        }
    }
    vector<vector<int>>multimi_componente(id_componenta);
    for(int i=0;i<graf.size();i++){
        cout<<i<<" "<<vizitat[i]<<"\n";
        multimi_componente[vizitat[i]].push_back(i);
    }
    return multimi_componente;
}

void Graf::dfs_prioritati(int nod, stack<int> &prioritati, vector<int> &vizitat) {
    vizitat[nod]=1;
    for(int i=0;i<graf[nod].size();i++){
        int vec=graf[nod][i];
        if(!vizitat[vec]){
            dfs_prioritati(vec,prioritati,vizitat);
        }
    }
    prioritati.push(nod);
}

void
Graf::dfs2_inverted(int nod, vector<vector<int>> &inverted, vector<int> &vizitat, int id, bool &b, vector<bool> &nf) {
    vizitat[nod]=id;
    if(nf[nod]){b=1;}
    for(int i=0;i<inverted[nod].size();i++){
        int vec=inverted[nod][i];
        if(!vizitat[vec]){
            dfs2_inverted(vec,inverted,vizitat,id,b,nf);
        }
    }
}

vector<vector<int>> Graf::InvertGraf() {
    vector<vector<int>> inverted(n);
    //inversam graful
    for(int i=0;i<graf.size();i++){
        for(int j=0;j<graf[i].size();j++){
            inverted[graf[i][j]].push_back(i);
        }
    }
    return inverted;
}

void Graf::afisare() {
    for(int i=0;i<n;i++){
        cout<<i<<": ";
        for(int j=0;j<graf[i].size();j++){
            cout<<graf[i][j]<<" ";
        }
        cout<<"\n";
    }
}


int main()
{
    int n,m;
    cin>>n>>m;
    vector<vector<int>> graf(n), edges;
    for(int i=0;i<m;i++){
        vector<int> t(2);
        cin>>t[0]>>t[1];
        edges.push_back(t);
        graf[t[0]].push_back(t[1]);
        graf[t[1]].push_back(t[0]);
    }
    Graf g(graf);
    vector<int> colorare=g.bipartit();
    return 0;
    if(colorare[n+1]==0){
        cout<<"NO";
    }
    else{
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

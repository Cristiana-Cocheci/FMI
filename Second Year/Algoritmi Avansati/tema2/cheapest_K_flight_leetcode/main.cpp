class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        //k<100, fac un vector de distante ptr fiecare nod in care retin cu ce lungime a drumului am ajuns acolo si cu ce cost
        int INF = 1000000000;
        //int distante[n][k+1];
        k++;
        vector<vector<int>> distante(n, vector<int> (k+1, INF));
        queue<pair<int,pair<int,int>>> coada; //nod, cu ce distanta si ce cost ajungem in el
        vector<vector<pair<int,int>>> graf(n);
        for(int i=0; i<flights.size();i++){
            int x = flights[i][0], y = flights[i][1], c=flights[i][2];
            graf[x].push_back({c,y});
        }
        coada.push({src,{0,0}});
        distante[src][0]=0;
        while(!coada.empty()){
            int cost=coada.front().second.second, lc=coada.front().second.first, nod=coada.front().first;
            coada.pop();
            if(distante[nod][lc]<cost){
                continue;
            }
            if(lc==k || nod==dst){
                continue;
            }
            for(int i=0;i<graf[nod].size();i++){
                    int vec=graf[nod][i].second, cost_vec=graf[nod][i].first;
                    if(distante[vec][lc+1]>cost+cost_vec){
                        cout<<vec<<" ";
                        distante[vec][lc+1]=cost+cost_vec;
                        coada.push({vec,{lc+1,cost+cost_vec}});
                    }
            }
        }
        int rez=INF;
        for(int i=0;i<=k;i++){
            //cout<<distante[dst][i]<<" ";
            rez=min(rez,distante[dst][i]);
        }
        if(rez==INF){
            return -1;
        }
        return rez;
    }
};

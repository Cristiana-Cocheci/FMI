#include <bits/stdc++.h>

using namespace std;

double INF = numeric_limits<double>::max();


double distanta_puncte(double a, double b, double c, double d){
    return sqrt((a-c)*(a-c) + (b-d)*(b-d));
}

int main()
{
    freopen("seg.in","r",stdin);
    freopen("seg.out","w",stdout);
    int Q;
    cin>>Q;

    for(int q=0;q<Q;q++){
        int N;
        double a,b,c,d;
        cin>>N;

        int subseturi = 1 << (N-1);
        vector<vector<double>> segmente;
        for(int i=0;i<N;i++){
            cin>>a>>b>>c>>d;
            segmente.push_back({a,b,c,d});
        }
        /**init**/
        vector<vector<pair<double,double>>> graf_dist_min(subseturi, vector<pair<double,double>>(N-1, {INF, INF})); //pair distante pentru cele doua noduri de pe un segment
        for(int i=0; i<N-1; i++){
            graf_dist_min[1 << i][i].first = distanta_puncte(segmente[i][0], segmente[i][1], segmente[N-1][0], segmente[N-1][1]);
            graf_dist_min[1 << i][i].second = distanta_puncte(segmente[i][2], segmente[i][3], segmente[N-1][0], segmente[N-1][1]) ;
        }
        /**dp**/
        for(int subset = 0; subset< (1<< (N-1)); subset++){
            for(int nod =0; nod <N-1; nod++){
                if(subset & (1<<nod)){ //nodul e in subset
                    for(int i = 0; i<N-1; i++){
                        if((subset & (1<<i))==0){ //nodul nu e in subset
                            int subset_nou = subset | (1<<i);
                            graf_dist_min[subset_nou][i].first = min(graf_dist_min[subset_nou][i].first, graf_dist_min[subset][nod].first + distanta_puncte(segmente[nod][2], segmente[nod][3], segmente[i][0], segmente[i][1]));
                            graf_dist_min[subset_nou][i].first = min(graf_dist_min[subset_nou][i].first, graf_dist_min[subset][nod].second + distanta_puncte(segmente[nod][0], segmente[nod][1], segmente[i][0], segmente[i][1]));
                            graf_dist_min[subset_nou][i].second = min(graf_dist_min[subset_nou][i].second, graf_dist_min[subset][nod].first + distanta_puncte(segmente[nod][2], segmente[nod][3], segmente[i][2], segmente[i][3]));
                            graf_dist_min[subset_nou][i].second = min(graf_dist_min[subset_nou][i].second, graf_dist_min[subset][nod].second + distanta_puncte(segmente[nod][0], segmente[nod][1], segmente[i][2], segmente[i][3]));
                        }
                    }
                }
            }
        }
        /**rez**/
        double rezultat = INF;
        for(int i=0; i< N-1; i++){
            int subset_toate = (1 << (N - 1)) - 1;
            double aux = min(graf_dist_min[subset_toate][i].first + distanta_puncte(segmente[N-1][2], segmente[N-1][3], segmente[i][2], segmente[i][3]),
                             graf_dist_min[subset_toate][i].second + distanta_puncte(segmente[N-1][2], segmente[N-1][3], segmente[i][0], segmente[i][1]));
            rezultat = min (rezultat, aux);
        }
        printf("%.6f\n", rezultat);
    }
    return 0;
}

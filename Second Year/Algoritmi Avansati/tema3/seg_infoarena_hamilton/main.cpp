#include <bits/stdc++.h>
#define NMAX 17

using namespace std;

double INF = numeric_limits<double>::max() / 3;


double dp[1<<NMAX][NMAX][2];



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
        vector<vector<double>> segmente;
        double distante[NMAX][NMAX][2][2];
        int N;
        double a,b,c,d;
        cin>>N;
        for(int i=0;i<N;i++){
            cin>>a>>b>>c>>d;
            segmente.push_back({a,b,c,d});
        }

        /************/
        for(int i=0;i<N; i++){
            for(int j=0;j<N-1; j++){
                int a1,a2,b1,b2,c1,c2,d1,d2;
                a1 = segmente[i][0];
                b1 = segmente[i][1];
                c1 = segmente[i][2];
                d1 = segmente[i][3];
                a2 = segmente[j][0];
                b2 = segmente[j][1];
                c2 = segmente[j][2];
                d2 = segmente[j][3];
                distante[i][j][0][0] = distanta_puncte(a1,b1,a2,b2);
                distante[i][j][0][1] = distanta_puncte(a1,b1,c2,d2);
                distante[i][j][1][0] = distanta_puncte(c1,d1,a2,b2);
                distante[i][j][1][1] = distanta_puncte(c1,d1,c2,d2);
            }
        }
        cout<<"\ndistante\n";
        for(int i=0;i<N; i++){
            for(int j=0;j<N-1; j++){
                cout<<distante[i][j][0][0]<<" "<<distante[i][j][0][1]<<" "<<distante[i][j][1][0]<<" "<<distante[i][j][1][1]<<"; ";
            }
            cout<<"\n";
        }
        cout<<"dp\n";
        for (int subset = 0; subset< (1<<(N-1)); subset++){
            for(int nod =0; nod<N; nod++){
                dp[subset][nod][0] = dp[subset][nod][1]=INF;
            }
        }
        dp[0][N-1][0]=0;
        for (int subset = 0; subset < (1 << (N - 1)); subset++) {
            for(int nod = 0; nod < N; nod++){
                if(((subset &(1 << nod)) >0) || nod == N-1){ //daca nodul e in subset
                    for(int vec =0; vec <N-1; vec++){
                        if((subset & (1<< vec)) == 0){ //vecinul nu e in subset
                            dp[subset | (1<<vec)][vec][0] = min (dp[subset| (1<<vec)][vec][0], dp[subset][nod][1] + distante[nod][vec][0][0]);
                            dp[subset | (1<<vec)][vec][0] = min (dp[subset| (1<<vec)][vec][0], dp[subset][nod][0] + distante[nod][vec][1][0]);
                            dp[subset | (1<<vec)][vec][1] = min (dp[subset| (1<<vec)][vec][1], dp[subset][nod][1] + distante[nod][vec][0][1]);
                            dp[subset | (1<<vec)][vec][1] = min (dp[subset| (1<<vec)][vec][1], dp[subset][nod][0] + distante[nod][vec][1][1]);
                            cout<<dp[subset | (1 << vec)][vec][0]<<" "<<dp[subset][nod][1] + distante[nod][vec][0][0]<<"\n";
                            cout<<dp[subset | (1 << vec)][vec][0]<<" "<<dp[subset][nod][0] + distante[nod][vec][1][0]<<"\n";
                            cout<<dp[subset | (1 << vec)][vec][1]<<" "<<dp[subset][nod][1] + distante[nod][vec][0][1]<<"\n";
                            cout<<dp[subset | (1 << vec)][vec][1]<<" "<<dp[subset][nod][0] + distante[nod][vec][1][1]<<"\n";

                        }
                    }
                }
            }
        }
        for(int subset = 0; subset < (1 << (N - 1)); subset++){
            cout<<subset<<" :: ";
            for(int nod = 0; nod<N; nod++){
                cout<<nod<<" "<<dp[subset][nod][0]<<" "<<dp[subset][nod][1]<<"; ";
            }
            cout<<"\n";
        }
        /************/
        double rez =INF;
        for(int nod =0; nod<N-1; nod++){
            rez = min(rez, dp[(1<<(N-1))-1][nod][0] + distanta_puncte(segmente[nod][2], segmente[nod][3], segmente[N-1][0], segmente[N-1][1]));
            rez = min(rez, dp[(1<<(N-1))-1][nod][1] + distanta_puncte(segmente[nod][0], segmente[nod][1], segmente[N-1][0], segmente[N-1][1]));
        }

        printf("%.6f\n", rez);

    }

    return 0;
}

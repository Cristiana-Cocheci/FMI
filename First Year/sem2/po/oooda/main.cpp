#include <iostream>
#include <fstream>
using namespace std;
ifstream fin("secv_fb.in");
ofstream fout("secv_fb.out");
int main()
{
    int n,k,v[100001],i,cnt=0;
    bool ok=1;
    fin>>n>>k;
    for(i=1;i<=n;i++)
    {
        fin>>v[i];
    }
    int st=1,dr=2;
    while(dr<=n){
        for(int j=dr-1;j>=st;j--){
            if(v[j]==v[dr]){
                st=j+1;
                break;
            }
        }
        if(dr-st+1==k){
            st++;
            cnt++;
        }
        dr++;

    }
    fout<<cnt;
    return 0;
}


#include <fstream>
#include <algorithm>

using namespace std;

int v[100010], w[100010], p[100010], f[100010];

int n, k, i, st, dr, mid, sol, rep;

int main () {
    ifstream fin ("secv_fb.in");
    ofstream fout("secv_fb.out");
    fin>>n>>k;
    for (i=1;i<=n;i++) {
        fin>>v[i];
        w[i] = v[i];
    }
    sort(w+1, w+n+1);

    p[1] = 1;
    for (i=2;i<=n;i++)
        if (w[i] == w[i-1])
            p[i] = p[i-1];
        else
            p[i] = 1+p[i-1];
    for (i=1;i<=n;i++) {
        st =1; dr = n;
        while (st <= dr) {
            mid = (st + dr)/2;
            if (w[mid] == v[i]) {
                v[i] = p[mid];
                break;
            }
            if (v[i] < w[mid])
                dr = mid - 1;
            else
                st = mid + 1;
        }
    }

    for (i=1;i<=n;i++) {
        f[ v[i] ]++;
        if (f[ v[i] ] == 2)
            rep++;
        if (i>k) {
            f[ v[i-k] ]--;
            if ( f[ v[i-k] ] == 1)
                rep--;
        }
        if (i >= k && rep == 0)
            sol++;
    }
    fout<<sol<<"\n";
    return 0;
}

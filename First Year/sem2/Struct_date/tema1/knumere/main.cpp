#include <bits/stdc++.h>
#define NMAX 1000007
using namespace std;

int v[NMAX],n,k,diferente[NMAX],minim_global=NMAX, max_pe_interval;

deque <int> stiva;

int main()
{
    freopen("knumere.in","r",stdin);
    freopen("knumere.out","w",stdout);
    scanf("%d%d",&n,&k);
    for(int i=1;i<=n;i++)
    {
        scanf("%d",&v[i]);
        diferente[i-1]=abs(v[i]-v[i-1]);
        //printf("%d ",diferente[i-1]);
    }
    int interval=n-k-1;
    for(int i=1;i<n;i++)
    {
        while(!stiva.empty() && diferente[stiva.back()]<diferente[i])
        {
            stiva.pop_back();
        }
        stiva.push_back(i);
        while(stiva.front()<i-interval+1)
        {
            stiva.pop_front();
        }
        if(i>=interval)
        {
            //printf("%d %d\n",i,v[stiva.front()]);
            //printf("%d\n",max_pe_interval);
            max_pe_interval=diferente[stiva.front()];
            if(max_pe_interval<minim_global)
            {
                minim_global=max_pe_interval;
            }
        }
    }
    printf("%d\n",minim_global);

    return 0;
}

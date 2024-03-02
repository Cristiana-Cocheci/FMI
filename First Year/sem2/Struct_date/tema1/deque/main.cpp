#include <bits/stdc++.h>
#define NMAX 5000010

using namespace std;
long long n,k,v[NMAX],smin=0;
deque <int> stiva;

int main()
{

    freopen("deque.in","r",stdin);
    freopen("deque.out","w",stdout);
    scanf("%lld%lld",&n,&k);
    for(int i=1;i<=n;i++)
    {
        scanf("%lld",&v[i]);
    }
    for(int i=1;i<=n;i++)
    {
        while(!stiva.empty() && v[stiva.back()]>v[i])
        {
            stiva.pop_back();
        }
        stiva.push_back(i);
        while(stiva.front()<i-k+1)
        {
            stiva.pop_front();
        }
        if(i>=k)
        {
            //printf("%d %d\n",i,v[stiva.front()]);
            smin+=v[stiva.front()];
        }
    }
    printf("%lld\n",smin);
    return 0;
}

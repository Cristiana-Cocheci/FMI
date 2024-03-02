#include <bits/stdc++.h>
#define NMAX 1000008

using namespace std;
stack <int> stiva;
int n,v[NMAX],nrgropi=0;

int main()
{
    freopen("nrpits.in","r",stdin);
    freopen("nrpits.out","w",stdout);
    scanf("%d",&n);
    for(int i=1;i<=n;i++)
    {
        scanf("%d",&v[i]);
    }
    for(int i=1;i<=n;i++)
    {
        if(!stiva.empty() && v[i]>v[stiva.top()])
        {
            stiva.pop();
        }
        while(!stiva.empty() && v[i]>v[stiva.top()])
        {
            nrgropi++;
            stiva.pop();
        }
        if(!stiva.empty() && i-1!=stiva.top())
        {
            nrgropi++;
        }
        stiva.push(i);
    }
    printf("%d",nrgropi);
    return 0;
}

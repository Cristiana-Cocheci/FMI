#include <bits/stdc++.h>

using namespace std;
int n,m;

priority_queue <int> procesoare;
priority_queue <pair<int,int>> v;

int main()
{
    freopen("proc2.in","r",stdin);
    freopen("proc2.out","w",stdout);
    scanf("%d%d",&n,&m);
    for(int i=1;i<=n;i++)
    {
        procesoare.push(-i);
    }
    for(int i=1;i<=m;i++)
    {
        int s,d,f;
        scanf("%d%d",&s,&d);
        f=s+d-1;
        while(!v.empty() && -v.top().first<s)
        {
            //printf("%d\n\n",v.top().second);
            procesoare.push(v.top().second);
            v.pop();
        }
        printf("%d\n",-procesoare.top());
        v.push({-f,procesoare.top()});
        procesoare.pop();

    }
    return 0;
}

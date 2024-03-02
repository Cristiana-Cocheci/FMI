#include <bits/stdc++.h>
#define N 40005

using namespace std;

int n,h[N],l[N],st[N],dr[N];

int stiva[N],pointer;

int main()
{
    freopen("skyline.in","r",stdin);
    freopen("skyline.out","w",stdout);
    scanf("%d",&n);

    for(int i=1;i<=n;i++)
    {
        scanf("%d%d",&h[i],&l[i]);
        l[i]+=l[i-1];
    }
    pointer=0;
    stiva[pointer]=0;
    for(int i=1;i<=n;i++)
    {
        while(pointer>0 && h[i]<=h[stiva[pointer]])
        {
            pointer--;
        }
        st[i]=stiva[pointer];
        stiva[++pointer]=i;
    }
    pointer=0;
    stiva[pointer]=n+1;
    for(int i=n;i>=1;i--)
    {
        while(pointer>0 && h[i]<=h[stiva[pointer]])
        {
            pointer--;
        }
        dr[i]=stiva[pointer];
        stiva[++pointer]=i;
    }
    int m=0;
    for(int i=1;i<=n;i++)
    {
        m=max(m,h[i]*(l[dr[i]-1]-l[st[i]]));
    }
    printf("%d",m);
    return 0;
}

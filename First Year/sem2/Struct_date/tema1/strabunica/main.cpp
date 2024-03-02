/*#include <bits/stdc++.h>
#define NMAX 200005

using namespace std;

long long n,v[NMAX],stg[NMAX],dr[NMAX];
long long maxx;
stack <int> st;

int main()
{
    freopen("strabunica.in","r",stdin);
    freopen("strabunica.out","w",stdout);
    scanf("%lld",&n);
    for(int i=1;i<n;i++)
    {
        scanf("%lld",&v[i]);
    }
    st.push(0);
    for(int i=1;i<=n;i++)
    {
        while(!st.empty() && v[i]<=v[st.top()])
        {
            st.pop();
        }
        if(!st.empty())
            stg[i]=st.top();
        st.push(i);
        //printf("%d ",stg[i]);
    }
    while(!st.empty())
    {
        st.pop();
    }
    st.push(n+1);
    //printf("\n");
    for(int i=n;i>0;i--)
    {
        while(!st.empty() && v[i]<=v[st.top()])
        {
            st.pop();
        }
        if(!st.empty())
            dr[i]=st.top();
        st.push(i);
        //printf("%d %d %d\n",i,v[i],dr[i]);
    }
    for(int i=1;i<=n;i++)
    {
        long long s=(long long)v[i]*(dr[i]-1-stg[i]);
        if(s>maxx)
            maxx=s;
    }

    printf("%lld",maxx);
    return 0;
}*/
#include <bits/stdc++.h>
#define N 200005

using namespace std;

long long n,h[N],st[N],dr[N];

stack <long long> v;

int main()
{
    freopen("strabunica.in","r",stdin);
    freopen("strabunica.out","w",stdout);
    scanf("%lld",&n);

    for(int i=1;i<=n;i++)
    {
        scanf("%lld",&h[i]);
    }
    v.push(0);
    for(int i=1;i<=n;i++)
    {
        while(!v.empty() && h[i]<=h[v.top()])
        {
            v.pop();
        }
        if(!v.empty())
        	st[i]=v.top();
        v.push(i);
    }
    while(!v.empty())
    {
        v.pop();
    }
    v.push(n+1);
    for(int i=n;i>=1;i--)
    {
        while(!v.empty() && h[i]<=h[v.top()])
        {
            v.pop();
        }
        if(!v.empty())
        	dr[i]=v.top();
        v.push(i);
    }
    long long m=0;
    for(int i=1;i<=n;i++)
    {
        m=max(m,(long long)h[i]*(dr[i]-1-st[i]));
    }
    printf("%lld",m);
    return 0;
}


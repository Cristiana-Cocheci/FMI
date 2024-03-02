#include <bits/stdc++.h>
#define NMAX 1000004

using namespace std;

int n,m;

priority_queue <pair<int,int>> v;

int main()
{
    freopen("proc2.in","r",stdin);
    freopen("proc2.out","w",stdout);
    scanf("%d%d",&n,&m);
    for(int i=1;i<=m;i++)
    {
        int x,y;
        scanf("%d %d",&x,&y);
        int terminare=(-1)*(x+y-1);
        printf("%d\n",terminare);
        if(i==1)
        {
            v.push({terminare,1});
            printf("1\n");
        }
        else
        {
            pair <int,int> t;
            t=v.top();
            printf("%d %d\n",t.first,t.second);
            while(t.first>terminare)
            {
                printf("11111");
                v.pop();
                t.first=0;
                v.push(t);
                t=v.top();
            }

            int aux=v.top().second+1;
            printf("%d\n",aux);
            v.push({terminare,aux});

        }

    }


    return 0;
}


/*int start,d;
    for(int i=1;i<=n;i++)
    {
        v.push(i);
    }
    for(int i=0;i<m;i++)
    {
        scanf("%d%d",&start,&d);
        bool ok=0;
        int p=1;
        while(!ok)
        {

        }
    }*/

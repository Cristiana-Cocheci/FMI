#include <bits/stdc++.h>

using namespace std;

int n,m,a[1005][1005],sume_linii[1005][1005];
int vechi[1005], nou[1005],vizitat[1005][1005],cnt,stg[1005],dr[1005];
stack <int> st;

int main()
{
    freopen("dreptunghiuri5.in","r",stdin);
    freopen("dreptunghiuri5.out","w",stdout);
    scanf("%d%d",&n,&m);
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=m;j++)
        {
            scanf("%d",&a[i][j]);
            sume_linii[i][j]=sume_linii[i][j-1]+a[i][j];
        }
    }
    for(int linie=1;linie<=n;linie++)
    {
        for(int coloana=1;coloana<=m;coloana++)
        {
            if(a[linie][coloana]==1)
            {
                nou[coloana]=0;
            }
            else
            {
                nou[coloana]=1+vechi[coloana];
            }
            vechi[coloana]=nou[coloana];
        }
        // strabunica pe nou[]
        for(int i=1;i<=m;i++)
        {
            while(!st.empty() && nou[i]<=nou[st.top()])
            {
                st.pop();
            }
            if(!st.empty())
                stg[i]=st.top()+1; //pt interval inchis
            else
                stg[i]=1;
            st.push(i);
        }
        while(!st.empty())
        {
            st.pop();
        }

        for(int i=m;i>=1;i--)
        {
            while(!st.empty() && nou[i]<=nou[st.top()])
            {
                st.pop();
            }
            if(!st.empty())
                dr[i]=st.top()-1; //pt interval inchis
            else
                dr[i]=m;
            st.push(i);
        }
        while(!st.empty())
        {
            st.pop();
        }
        //secvente maximale pe linie
        for(int i=1;i<=m;i++)
        {
            int left=stg[i],right=dr[i];
            if(!vizitat[left][right] && a[linie][i]==0)
            {
                //daca nu se poate extinde in jos
                //suma partiala pe linie
                int s=sume_linii[linie+1][right]-sume_linii[1+linie][left-1] + (linie==n);
                if(s!=0)
                {
                    cnt++;
                    //printf("%d %d\n", left,right);
                    vizitat[left][right]=1;
                }
            }
        }

        for(int i=1;i<=m;i++)
        {
            int left=stg[i],right=dr[i];
            vizitat[left][right]=0;
        }
    }
    printf("%d",cnt);
    return 0;
}

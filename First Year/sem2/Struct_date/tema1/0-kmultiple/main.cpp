#include <bits/stdc++.h>
#define NMAX 100005

using namespace std;

int n,k,resturi[NMAX][2],vizitat[NMAX],tata[NMAX],cifra[NMAX];

queue <int> coada;
stack <int> drum;

int main()
{
    scanf("%d%d",&n,&k);
    for(int i=0;i<n;i++)
    {
        resturi[i][0]=i*10 %n;
        resturi[i][1]=(i*10+k) %n;
        tata[i]=-1;
    }
    coada.push(k%n);
    vizitat[k%n]=1;
    //bfs
    while(!coada.empty())
    {
        for(int i=0;i<2;i++)
        {
            if(!vizitat[resturi[coada.front()][i]])
            {
                vizitat[resturi[coada.front()][i]]=1;
                tata[resturi[coada.front()][i]]=coada.front();
                cifra[resturi[coada.front()][i]]=i;
                coada.push(resturi[coada.front()][i]);
            }
        }
        coada.pop();
    }
   // drum.push(1);
    int nod=0;
    while(tata[nod]!=-1)
    {
        drum.push(cifra[nod]);
        nod=tata[nod];
    }
    drum.push(1);
    while(!drum.empty())
    {
        if(drum.top()==1)
            printf("%d",k);
        else
            printf("0");
        drum.pop();
    }
    return 0;
}

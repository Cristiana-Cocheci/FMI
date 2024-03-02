#include <bits/stdc++.h>
#define NMAX 100005

using namespace std;

int n,k,resturi[NMAX][2],vizitat[NMAX],tata[NMAX],cifra[NMAX];

queue <int> coada;
stack <int> drum;



void goleste_coada()
{
    //printf("OOO");
    while(!coada.empty())
    {
        coada.pop();
    }
}

void afiseaza(int nod)
{
    drum.push(cifra[nod]);
    //printf("L");
    while(tata[nod]!=-1)
    {
        printf("P");
        //printf("%d",cifra[tata[nod]]);
        drum.push(cifra[tata[nod]]);
        nod=tata[nod];
    }
    return;
}

int main()
{
    scanf("%d%d",&n,&k);
    for(int i=0;i<n;i++)
    {
        resturi[i][0]=i*10 %n;
        resturi[i][1]=(i*10+k) %n;
        tata[i]=-1;
    }
    coada.push(k);
    vizitat[k]=1;
    //bfs
    while(!coada.empty())
    {
        for(int i=0;i<2;i++)
        {
            if(resturi[coada.front()][i]==0 )
            {
                //printf("1");
                //drum.push(i);
                cifra[coada.front()]=i;
                //tata[resturi[coada.front()][i]]=coada.front();
                afiseaza(coada.front());
                //printf("%d\n",coada.size());
                goleste_coada();
                //printf("%d\n",coada.size());

                break;
            }
            else if(!vizitat[resturi[coada.front()][i]])
            {
                //printf("5");
                vizitat[resturi[coada.front()][i]]=1;
                tata[resturi[coada.front()][i]]=coada.front();
                cifra[resturi[coada.front()][i]]=i;
                coada.push(resturi[coada.front()][i]);
            }
        }
        //printf("lkhk");
        if(!coada.empty()){coada.pop();}
       // printf("PPP");
    }
    //printf("K");
    drum.push(1);
    /*for(int i=0;i<drum.size();i++)
    {
        printf("%d",drum[i]);
    }*/
    //printf("%d\n",drum.size());
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

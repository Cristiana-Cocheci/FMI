#include <iostream>
#include <bits/stdc++.h>

using namespace std;

struct trie
{
    struct trie *litere[26]; //vector de pointeri
    int endofword=0;
};

struct trie *adaugNod(void)
{
    struct trie *nod_nou= new trie;
    nod_nou->endofword=0;
    for(int i=0;i<26;i++)
    {
        nod_nou->litere[i]=nullptr;
    }
    return nod_nou;
};

void adaugaCuv(struct trie *root, string cuv)
{
    sruct trie *pointer=root;
    for(int i=0;i<cuv.length();i++)
    {
        int index=cuv[i]-'a';
        if(!pointer->litere[index])
        {
            pointer->litere[index]=adaugNod();
        }
        pointer = pointer->litere[index];
    }
    pointer->endofword++;

}
int nr_aparitii(struct trie *root, string cuv)
{
    struct trie *pounter=root;
    for(int i=0; i<cuv.le)
}

int main()
{
    freopen("trie.in","r",stdin);
    freopen("trie.out","w",stdout);
    int q;
    string cuv;
    while(scanf("%d",&q) !=EOF)
    {
        gets(cuv);
        if(q==0)
        {
            //adaugare aparitie
            adaugaCuv(cuv);
        }
        else if(q==1)
        {
            //stergere aparitie
            sterge(cuv);
        }
        else if(q==2)
        {
            //nr aparitii
            printf("%d\n",nr_aparitii(cuv));
        }
        else
        {
            //cel mai lung prefix comun
            printf("%d\n",lcp(cuv));
        }
    }
    return 0;
}

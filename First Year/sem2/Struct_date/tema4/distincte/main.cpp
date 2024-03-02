#include <iostream>
#include <vector>
#include<algorithm>

class arbore
{
private:
    int n;
    std::vector<long long> v;
public:
    void build(int poz, int l, int r, const std::vector<int> &vec)
    {
        if(l==r){
            v[poz]=vec[l];
            return;
        }
        int m=(l+r)/2;
        int lchild=2*poz, rchild=2*poz+1;
        build(lchild,l,m,vec);
        build(rchild,m+1,r,vec);
        v[poz]= v[lchild] + v[rchild];
    }
    arbore(int _n,const std::vector<int> &_v): n(_n), v(4*_n)
    {
        build(1,0,n-1,_v);
    }

    long long query(int l, int r){
        return query(1,0,n-1,l,r);
    }
    void update(int poz, int aux)
    {
        update(1,0,n-1,poz,poz,aux);
    }
    long long query(int poz, int l, int r, int lq, int rq){
        if (lq <= l && r <= rq) {
          return v[poz];
        }
        int m = (l + r) / 2;
        long long lsum = 0, rsum = 0;
        if (lq <= m) {
          lsum = query(2 * poz, l, m, lq, rq);
        }
        if (rq > m) {
          rsum = query(2 * poz + 1, m + 1, r, lq, rq);
        }
        return lsum + rsum;
    }
    void update(int poz, int l, int r, int ql, int qr, int aux) {
         if (ql <= l && r <= qr) {
          v[poz]+=aux;
          return;
        }
        int m = (l + r) / 2;
        if (ql <= m) {
          update(2 * poz, l, m, ql, qr, aux);
        }
        if (qr > m) {
          update(2 * poz + 1, m + 1, r, ql, qr, aux);
        }
        int lchild=2*poz, rchild=2*poz+1;
        v[poz]=v[lchild]+v[rchild];
  }
};

bool compar(std::pair<int,std::pair<int,int>> a, std::pair<int,std::pair<int,int>> b)
{
    int x=a.second.second;
    int y=b.second.second;
    if(x<y){
        return 1;
    }
    return 0;
}

int main()
{
    freopen("distincte.in","r",stdin);
    freopen("distincte.out","w",stdout);
    int n,q,k;
    std::cin>> n>>k>>q;
    std::vector<int> v(n);
    arbore AINT(n,v);
    for(int i=0;i<n;i++){
        std::cin>>v[i];
    }
    std::vector<std::pair<int,std::pair<int,int>>> intervale;
    for(int i=0;i<q;i++){
        int l,r;
        std::cin>>l>>r;
        l--;r--;
        intervale.push_back(std::make_pair(i,std::make_pair(l,r)));

    }

    std::sort(intervale.begin(),intervale.end(),compar);


    long long rez[q], ultima_aparitie[k+3];
    for(int i=0;i<k+1;i++)
    {
        ultima_aparitie[i]=-1;
    }
    int j=0;
    for(int i=0;i<n;i++)
    {
        if(ultima_aparitie[v[i]]!=-1){
            AINT.update(ultima_aparitie[v[i]],-v[i]);
        }
        AINT.update(i,v[i]);
        ultima_aparitie[v[i]]=i;
        while(j<q && intervale[j].second.second==i){

            rez[intervale[j].first]=AINT.query(intervale[j].second.first, intervale[j].second.second);
            j++;
        }
    }
    for(int i=0;i<q;i++){
        std::cout<<rez[i]%666013<<"\n";
    }

    return 0;
}

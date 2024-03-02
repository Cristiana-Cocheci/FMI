#include <iostream>
#include <vector>

class arbore
{
private:
    int n;
    std::vector<int> v, lazy;
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
        v[poz]=std::max(v[lchild], v[rchild]);
    }
    arbore(int _n,const std::vector<int> &_v): n(_n), v(4*_n), lazy(4*_n)
    {
        build(1,0,n-1,_v);
    }
    void push(int poz, int l, int r){
        int lchild=2*poz, rchild=2*poz+1;
        if(l!=r){
            v[lchild] += lazy[poz];
            v[rchild] += lazy[poz];
            lazy[lchild]+= lazy[poz];
            lazy[rchild]+= lazy[poz];
        }
        lazy[poz]=0;
    }
    int query(int l, int r){
        return query(1,0,n-1,l,r);
    }
    void update(int l, int r, int aux)
    {
        update(1,0,n-1,l,r,aux);
    }
    int query(int poz, int l, int r, int lq, int rq){
        push(poz,l,r);
        if (lq <= l && r <= rq) {
          return v[poz];
        }
        int m = (l + r) / 2;
        int lmax = 0, rmax = 0;
        if (lq <= m) {
          lmax = query(2 * poz, l, m, lq, rq);
        }
        if (rq > m) {
          rmax = query(2 * poz + 1, m + 1, r, lq, rq);
        }
        return std::max(lmax, rmax);
    }
    void update(int poz, int l, int r, int ql, int qr, int aux) {
        push(poz, l, r);
        if (ql <= l && r <= qr) {
          v[poz] += aux;
          lazy[poz] += aux;
          push(poz, l, r);
          return;
        }
        int m = (l + r) / 2;
        if (ql <= m) {
          update(2 * poz, l, m, ql, qr, aux);
        }
        if (qr > m) {
          update(2 * poz + 1, m + 1, r, ql, qr, aux);
        }
        v[poz] = std::max(v[2 * poz], v[2 * poz + 1]);
  }
};

int main()
{
    freopen("mit.in","r",stdin);
    freopen("mit.out","w",stdout);
    int n,q;
    std::cin>> n>>q;
    std::vector<int> v(n);
    for(int i=0;i<n;i++){
        std::cin>>v[i];
    }
    arbore AINT(n,v);
    for(int i=0;i<q;i++){
        int t,l,r;
        std::cin>>t>>l>>r;
        l--;r--;
        if(t==1){
            std::cout<<AINT.query(l,r)<<"\n";
        }
        else{
            int aux;
            std::cin>>aux;
            AINT.update(l,r,aux);
        }
    }

    return 0;
}

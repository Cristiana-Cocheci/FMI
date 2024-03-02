#include <iostream>
#include <vector>

class arbore
{
private:
    int n;
    struct mmai
    {
        long long maxime, rsufix, lsufix, sum;
    };
    std::vector<mmai> maxx;

public:
    mmai combin(mmai lmax, mmai rmax){
        mmai aux;
        aux.sum=lmax.sum+rmax.sum;
        aux.lsufix=std::max(lmax.lsufix,lmax.sum+rmax.lsufix);
        aux.rsufix=std::max(rmax.rsufix, lmax.rsufix+rmax.sum);
        aux.maxime=std::max(std::max(lmax.maxime, rmax.maxime), lmax.rsufix+rmax.lsufix);
        return aux;
    }

    void build(int poz, int l, int r, const std::vector<int> &vec)
    {
        if(l==r)
        {
            maxx[poz].maxime=maxx[poz].rsufix=maxx[poz].lsufix=std::max(0,vec[l]);
            maxx[poz].sum=vec[l];
            return;
        }
        int m=(l+r)/2;
        int lchild=2*poz, rchild=2*poz+1;
        build(lchild,l,m,vec);
        build(rchild,m+1,r,vec);
        maxx[poz]=combin(maxx[lchild],maxx[rchild]);
        /*maxx[poz].sum= maxx[lchild].sum+ maxx[rchild].sum;
        maxx[poz].rsufix=std::max(maxx[rchild].rsufix, maxx[lchild].rsufix+maxx[rchild].sum);
        maxx[poz].lsufix=std::max(maxx[lchild].lsufix, maxx[rchild].lsufix+maxx[lchild].sum);
        maxx[poz].maxime=std::max(std::max(maxx[lchild].maxime, maxx[rchild].maxime), maxx[lchild].rsufix+ maxx[rchild].lsufix);
*/    }
    arbore(int _n,const std::vector<int> &_v): n(_n),maxx(4*_n)
    {
        build(1,0,n-1,_v);
    }

    long long query(int l, int r){
        mmai rez= query(1,0,n-1,l,r);
        return rez.maxime;
    }
    void update(int poz, int aux)
    {
        update(1,0,n-1,poz,poz,aux);
    }


    mmai query(int poz, int l, int r, int lq, int rq){

        if (lq <= l && r <= rq) {
          return maxx[poz];
        }
        int m = (l + r) / 2;
        mmai aux;
        aux.lsufix=0;
        aux.rsufix=0;
        aux.maxime=0;
        aux.sum=0;
        mmai lmax = aux, rmax = aux;
        if (lq <= m) {
          lmax = query(2 * poz, l, m, lq, rq);
        }
        if (rq > m) {
          rmax = query(2 * poz + 1, m + 1, r, lq, rq);
        }
        return combin(lmax,rmax);
    }

    void update(int poz, int l, int r, int ql, int qr, int aux) {

        if (ql <= l && r <= qr) {
          maxx[poz].maxime=maxx[poz].rsufix=maxx[poz].lsufix=std::max(0,aux);
            maxx[poz].sum=aux;
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
        maxx[poz]=combin(maxx[lchild],maxx[rchild]);
        /*maxx[poz].sum= maxx[lchild].sum+ maxx[rchild].sum;
        maxx[poz].rsufix=std::max(maxx[rchild].rsufix, maxx[lchild].rsufix+maxx[rchild].sum);
        maxx[poz].lsufix=std::max(maxx[lchild].lsufix, maxx[rchild].lsufix+maxx[lchild].sum);
        maxx[poz].maxime=std::max(std::max(maxx[lchild].maxime, maxx[rchild].maxime), maxx[lchild].rsufix+ maxx[rchild].lsufix);
*/
  }
};

int main()
{
    freopen("maxq.in","r",stdin);
    freopen("maxq.out","w",stdout);
    int n,q;
    std::cin>> n;
    std::vector<int> v(n);
    for(int i=0;i<n;i++){
        std::cin>>v[i];
    }
    std::cin>>q;
    arbore AINT(n,v);
    for(int i=0;i<q;i++){
        int t,l,r;
        std::cin>>t;

        if(t==1){
            std::cin>>l>>r;
            std::cout<<AINT.query(l,r)<<"\n";
        }
        else{
            int poz,aux;
            std::cin>>poz>>aux;
            AINT.update(poz,aux);
        }
    }

    return 0;
}

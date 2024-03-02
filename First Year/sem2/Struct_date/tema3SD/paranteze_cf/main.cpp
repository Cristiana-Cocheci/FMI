#include <iostream>
#include <vector>

class arbore
{
private:
    int n;
    struct mmai
    {
        int deschise, inchise, corecte;
    };
    std::vector<mmai> maxx;

public:
    mmai combin(mmai l, mmai r){
        mmai aux;
        aux.corecte=l.corecte+r.corecte+ std::min(l.deschise, r.inchise);
        aux.deschise=l.deschise+ r.deschise-std::min(l.deschise, r.inchise);
        aux.inchise= l.inchise+ r.inchise -std::min(l.deschise, r.inchise);
        return aux;
    }

    void build(int poz, int l, int r, const std::vector<int> &vec)
    {
        if(l==r)
        {
            maxx[poz].corecte=0;
            if(vec[l]==1){
                maxx[poz].deschise=1;
            }
            else{
                maxx[poz].inchise=1;
            }
            return;
        }
        int m=(l+r)/2;
        int lchild=2*poz, rchild=2*poz+1;
        build(lchild,l,m,vec);
        build(rchild,m+1,r,vec);
        maxx[poz]=combin(maxx[lchild],maxx[rchild]);

}
    arbore(int _n,const std::vector<int> &_v): n(_n),maxx(4*_n)
    {
        build(1,0,n-1,_v);
    }

    int query(int l, int r){
        mmai rez= query(1,0,n-1,l,r);
        return rez.corecte;
    }
    mmai query(int poz, int l, int r, int lq, int rq){

        if (lq <= l && r <= rq) {
          return maxx[poz];
        }
        int m = (l + r) / 2;
        mmai aux;
        aux.corecte=0;
        aux.inchise=0;
        aux.deschise=0;
        mmai lmax = aux, rmax = aux;
        if (lq <= m) {
          lmax = query(2 * poz, l, m, lq, rq);
        }
        if (rq > m) {
          rmax = query(2 * poz + 1, m + 1, r, lq, rq);
        }
        return combin(lmax,rmax);
    }

};

int main()
{
    //freopen("input.in","r",stdin);
    //freopen("output.out","w",stdout);
    std::string paranteze;
    std::cin>> paranteze;
    std::vector<int> v(paranteze.size());
    for(int i=0;i<paranteze.size();i++){
        if(paranteze[i]=='('){
            v[i]=1;
        }
        else{
            v[i]=-1;
        }
    }
    int q,l,r;
    std::cin>>q;
    arbore AINT(paranteze.size(),v);
    for(int i=0;i<q;i++){
        std::cin>>l>>r;
        l--;r--;
        std::cout<<2*AINT.query(l,r)<<"\n";
    }

    return 0;
}

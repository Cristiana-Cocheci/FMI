#include <iostream>
#include <vector>

class arbore
{
    int n;
    struct mmai
    {
        long long prefix, sufix, sum, secvMax, lazy;
    };
    std::vector<mmai> maxx;

public:
    mmai combin(mmai l, mmai r){
        mmai aux;
        aux.lazy=0;
        aux.sum=l.sum+r.sum;
        if(l.sufix==l.sum){
            aux.prefix= l.sum+r.prefix;
        }
        else{
            aux.prefix= l.prefix;
        }
        if(r.sufix==r.sum){
            aux.sufix=r.sum+ l.sufix;
        }
        else{
            aux.sufix=r.sufix;
        }
        aux.secvMax=std::max(std::max(l.secvMax,r.secvMax),l.sufix+r.prefix);
        return aux;
    }

    void push(int poz, int l, int r){
        int lchild=2*poz, rchild=2*poz+1;
        if(maxx[poz].lazy!=0){
            if(l!=r){
                if(maxx[poz].lazy==1)
                {
                    maxx[lchild].prefix= maxx[lchild].sum;
                    maxx[lchild].sufix= maxx[lchild].sum;
                    maxx[lchild].secvMax= maxx[lchild].sum;

                    maxx[rchild].prefix= maxx[rchild].sum;
                    maxx[rchild].sufix= maxx[rchild].sum;
                    maxx[rchild].secvMax= maxx[rchild].sum;
                }
                else
                {
                    maxx[lchild].prefix= 0;
                    maxx[lchild].sufix= 0;
                    maxx[lchild].secvMax= 0;

                    maxx[rchild].prefix= 0;
                    maxx[rchild].sufix= 0;
                    maxx[rchild].secvMax= 0;
                }
                maxx[lchild].lazy = maxx[poz].lazy;
                maxx[rchild].lazy = maxx[poz].lazy;
            }
            maxx[poz].lazy=0;
        }
    }


    void build(int poz, int l, int r, const std::vector<int> &vec)
    {
        if(l==r)
        {
            maxx[poz].secvMax=1;
            maxx[poz].prefix=1;
            maxx[poz].sufix=1;
            maxx[poz].sum=1;
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

    int query(){
        return maxx[1].secvMax;

    }
    void update(int l,int r, int aux){
        update(1,0,n-1,l,r,aux);
    }

    void update(int poz, int l, int r, int ql, int qr, int aux) {
        push(poz, l, r);
        if (ql <= l && r <= qr) {
            if(aux==1)
            {
                maxx[poz].prefix= maxx[poz].sum;
                maxx[poz].sufix= maxx[poz].sum;
                maxx[poz].secvMax= maxx[poz].sum;
            }
            else
            {
                maxx[poz].prefix = 0;
                maxx[poz].sufix = 0;
                maxx[poz].secvMax = 0;
            }

          maxx[poz].lazy = aux;
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
        maxx[poz] = combin(maxx[2 * poz], maxx[2 * poz + 1]);
  }

};

int main()
{
    freopen("hotel.in","r",stdin);
    freopen("hotel.out","w",stdout);
    int n,q,t,l,m;
    std::cin>> n>>q;
    std::vector<int> v(n,1);
    arbore AINT(n,v);
    for(int i=0;i<q;i++){
        std::cin>>t;
        if(t==1){
            std::cin>>l>>m;
            l--;
            AINT.update(l,l+m-1,-1);
        }
        else if(t==2){
            std::cin>>l>>m;
            l--;
            AINT.update(l,l+m-1,1);
        }
        else{
            std::cout<<AINT.query()<<"\n";
        }
    }

    return 0;
}

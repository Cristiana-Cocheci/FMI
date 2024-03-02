#include <iostream>

using namespace std;

int main()
{
    int n,m,c;
    cout<<21/2*2-5;
    cin>>n;
    m=0;
    do{
        c=n%10;
        n/=10;
        if(c==0){
            c=2;
        }
        else{
            if(c%2==0){
                c=0;
            }
        }
        m=m*10+c;
    }
    while(n!=0);
    cout<<m;
    return 0;
}

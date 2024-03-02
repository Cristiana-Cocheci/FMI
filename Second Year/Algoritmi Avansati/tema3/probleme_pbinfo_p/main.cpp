#include <iostream>

using namespace std;

int main()
{
    int n, rez=0, p=1, z=1, suma_cifre=0, nr_cifre=0;
    cin>>n;
    while(n>0){
        int c=n%10;
        n=n/10;
        suma_cifre = suma_cifre + c;
        nr_cifre++;
    }
    for(int i=1;i<nr_cifre;i++){
        p=p*i; //1*2*3*..*(n-1)
    }
    //cout<<nr_cifre<<" "<<suma_cifre<<" "<<p;
    for(int i=1;i<=nr_cifre;i++){
        rez = rez + p*z*suma_cifre;
        z = z*10;
    }
    cout<<rez;
    return 0;
}

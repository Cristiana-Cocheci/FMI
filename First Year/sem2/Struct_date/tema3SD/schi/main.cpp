#include <iostream>
#include <vector>
int n;
std::vector<int> clasament;

int main()
{
    freopen("schi.in","r",stdin);
    freopen("schi.out","w",stdout);
    clasament.push_back(-1); //size=1, poz=0
    std::cin>>n;
    for(int val=1;val<=n;val++){
        int poz;
        std::cin>>poz;
        clasament.insert(clasament.begin()+poz,val);
    }
    for(int i=1;i<=n;i++){
        std::cout<<clasament[i]<<"\n";
    }
    return 0;
}

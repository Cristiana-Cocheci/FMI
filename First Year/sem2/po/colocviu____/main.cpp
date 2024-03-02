#include <iostream>

using namespace std;

class Data{
int zi,luna,an;
public:
    Data(int z,int l,int a): zi(z),luna(l),an(a){}
    std::ostream& operator <<(std::ostream& os, const Data& d){
    os<<d.zi<<" "<<d.luna<<" "<< d.an;
    return os;
    }
};


class invalid_name: public app_error{
using app_error::app_error;
};

class malware{
    float rating;
    Data data;
    std::string nume;
    std::string met="unk";
    std::vector<std::string> regs;
public:
    malware(Data d, std::string n, std::string m, std::vector<std::string>r: data(d), nume(n), met(m), regs(r){}

};

class rootkit{
    std::vector<std::string> imps;
    std::vector<std::string> strs;
public:
    rootkit(Data d, std::string n, std::string m, std::vector<std::string>r, std::vector<std::string>im, std::vector<std::string>st:
             malware(d,n,m,r), imps(), strs(){}

};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}

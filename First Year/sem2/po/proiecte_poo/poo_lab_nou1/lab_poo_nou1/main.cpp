#include <iostream>
#include <vector>
class Haina {
    std::string culoare = "gri";
    int pret=100;
public:
    Haina(const std::string &culoare, int pret) : culoare(culoare), pret(pret) {}
    Haina(const Haina& other) : culoare(other.culoare),pret(other.pret)
    {
        std:: cout <<"cc haina \n";
    }
    Haina& operator=(const Haina& other)
    {
        culoare=other.culoare;
        pret=other.pret;
        std::cout <<"op= haina\n";
        return *this;
    }
    friend std::ostream &operator<<(std::ostream)
};
class Cuier {
    int nr_haine_max;
    Haina h{"a", 1};
//    std::string material;
//    std::vector<Haina> haine;
public:
//    Cuier(const std::string &material, const std::vector<Haina> &haine) : material(material), haine(haine) {}
};
int main() {
    Haina h1{"a", 1};
    Cuier c1;
    std::vector<Cuier> vec;
    vec.push_back(c1);
    return 0;
}

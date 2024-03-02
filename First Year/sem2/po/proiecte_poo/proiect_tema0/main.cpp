#include <iostream>
#include <vector>

class Cantaret{
    std::string nume;
    char voce; //b=bas, t=tenor, a=alto, s=soprana
public:
    Cantaret(const std::string& nume_="unknown", char voce_='?'): nume(nume_), voce(voce_){

    }

};

class Dirijor{
    std::string nume;
    int varsta;
public:
    Dirijor(const std::string& nume_="unknown", int varsta_=-1): nume(nume_), varsta(varsta_){

    }

};
class Melodie{
    std::string titlu;
    std::string limba;
    float durata;
    int nr_voci;
public:
    Melodie(const std::string& titlu_="nu_stiu", const std::string& limba_="gibberish", float durata_=0, int nr_voci_=0):
        titlu(titlu_),limba(limba_),durata(durata_),nr_voci(nr_voci_){}
    friend std::ostream& operator<<(std::ostream& os, const Melodie& m)
    {
        os<< "Nume: "<<m.titlu<<",limba: "<<m.limba<<", durata: "<< m.durata<<",numar de voci: "<<m.nr_voci;
        return os;
    }
};

class Cor{
    std::vector<Cantaret> oameni;
    Dirijor d;
    std::string nume_cor;
    std::vector<Melodie> repertoriu;
public:

};

int main() {
    Melodie m("Africa");
    std::cout << m;
    return 0;
}

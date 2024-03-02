#include <bits/stdc++.h>

using namespace std;

class Magazin;

istream& operator>>(istream& in, Produs&p)
{
    in>> p.denumire >> p.pret >> p.cantitate;
    return in;
    //return in >> p.denumire >> p.pret >> p.cantitate;
}

void Produs :: afisare()
{
    cout << denumire << " " << pret << " " << cantitate <<"\n";
}

ostream& operator<<(ostream& out, Produ& p)
{
    return out << p.denumire << " " << p.pret << " " << p.cantitate;
    /* sau, nu e recomandat, dar se poate si asa
    p.afisare();
    return out;
    */
}

/*Produs& Produs:: operator-(float x){ pret-=x; return *this;}
//obs!!, este ok pt p2=p2-1.2, dar nu mai e ok pentru p3=p2-1.2(pentru ca modifica si p2)
*/
Produs Produs::operator-(float x){ return Produs(denumire, pret-x, cantitate);}
Produs& Produs:: operator++(){ cantitate++; return *this;}
Produs Produs:: operator++(int){ return Produs(denumire, pret, cantitate++;}

bool Produs::operator(const Produs &p)
{return denumire==p.denumire && pret==p.pret && cantitate==p.cantitate;}

class Produs
{
private:
    string denumire;
    float pret; //daca avem const float se poate initializa numai in lista de initializare a constructorului
    int cantitate;

public:
    Produs(const string& s="",float p=0, int c=0):
        denumire(s), pret(p), cantitate(c){} //lista de initializare a constructorului
    friend istream& operator>>(istream&, Produs&);
    friend ostream& operator<<(ostream&, Produs&);
    operator float(){return pret;}
    Produs operator-(float);
    Produs& operator++();
    Produs operator++(int);
    bool operator==(const Produs&);
    friend class Magazin;
    void afisare();
};

class Magazin
{
private:
    int nrProduse;
    Produs v[20];
public:
    Magazin(){}
    istream& operator>>(istream &in, Magazin& m)
    {
        int i;
        in >> m.nrProduse;
        for(i=0;i<m.nrProduse;++i)
        {
            in >> m.v[i];
        }
        return in;
    }
    ostream& operator<<(ostream &out, const Magazin& m)
    {
        int i;
        out << m.nrProduse << "\n";
        for(i=0;i<m.nrProduse;++i)
        {
            out << m.v[i] << " ";
        }
        return out;
    }
    Produs *operator[](const string& denumire)
    {
        int i;
        for(i=0;i<nrProduse;i++)
        {
            if(v[i].denumire == denumire)
            {
                return &v[i]; //v+i
            }
        }
        return nullptr;
    }
    Produs *operator[](int i)
    {
        if(!(i>0 && i<nrProduse)) throw -1;
        return v[i];
        return nullptr;
    }

};

int main()
{
    Produs p1,p2("apa",3.5,1);
    cin>>p1;
    cout<<p1<<p2;
    p2=p2-1.2;
    p1++;
    ++p1;
    if(p1==p2)
    {
        cout<< "acelasi";
    }
    else
    {
        cout<<"NU";
    }
    Magazin m;
    cin>>m;
    cout<<m;
    m+=p1;
    m=m+p2;
    //cout<<m[1]<<"\n";
    try
    {
        cout<<m[1];
    }
    catch(int *)
    {
        cout<< "ai dat o n bara";
    }
    (m["apa"])->afisare();
    cout<<-m;
    float pret=m[0];
    cout<<pret;
    return 0;
}

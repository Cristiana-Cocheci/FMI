///1024 de megaimge face 1 giga image

#include <iostream>

using namespace std;

class Profesor
{
    private:
        int vechime;
        char *nume;
    public:
        Profesor(const char *_nume = 0, int _vechime = 0): vechime(_vechime)
        {
            if(_nume==0) {nume=0;}
            else
            {
                int l=strlen(_nume);
                nume= new char[l+1]; //ca sa avem loc de \0 la finalul sirului
                strcpy(nume,_nume);
            }
        }
        Profesor(const Profesor & other)
        {
            vechime = other.vechime;
            if (other.nume==0){nume=0;}
            else
            {
                nume= new char[strlen(other.nume)+1];
                strcpy(nume, _nume);
            }
        }
        ~Profesor()
        {
            if(nume!=0)
            {
                delete[] nume;
            }
        }
        friend istream& operator >> (istream& in, Profesor& p)
        {
            in >> vechime;
            char aux[256];
            in >> aux;
            if(p.nume!=0){ delete[] p.nume; }
            p.nume= new char[strlen(aux)+1];
            strcpy(p.nume, aux);
            return in;
        }
        friend ostream& operator << (ostream & out, const Profesor &p)
        {
            return out << p.vechime << ' ' << p.nume;
        }

        const char* get_nume()
        {
            return nume;
        }
        /// mai trebuie scris operatorul de atribuire

};

class Student
{
private:
    int grupa;
    char nume[64];
public:
    /// tema constructor+destructor
    Student & operator +=(int gr)
    {
        grupa=gr;
        return *this; //this e un pointer, vrem sa obtinem obiectul
    }
    bool operator != (const Student&other)
    {
        return grupa != other.grupa || strcmp(nume, other.nume); //compara doi studenti, returneaza true sau false
    }
    friend bool operator !=(const Student&s1, const Student&s2)
    {
        return s1.grupa !=s2.grupa || strcmp(s1.nume, s2.nume);
    }
};

int main()
{

    return 0;
}

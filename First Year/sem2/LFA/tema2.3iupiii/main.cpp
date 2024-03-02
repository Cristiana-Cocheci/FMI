#include <iostream>
#include <bits/stdc++.h>

class Automat{
protected:
    int Q; //nr de stari
    int q0; //stare initiala
    int alfabet; // alfabetul e format din numere de la 0 la "alfabet"
    std::vector<int> sf; //starile finale
    std::vector<std::vector<int>> matr;
public:
    Automat(){}
    Automat(int Q_, int q0_, int alfabet_, std::vector<int> sf_):
        Q(Q_), q0(q0_), alfabet(alfabet_), sf(sf_), matr(Q, std::vector<int>(alfabet,0)){} //constructor folosit pentru citire
    Automat(int Q_, int q0_, int alfabet_, std::vector<int> sf_,std::vector<std::vector<int>> matr_):
        Q(Q_), q0(q0_), alfabet(alfabet_), sf(sf_), matr(matr_){} //constructor apelat in functia transform_in_DFA
};

class DFA:public Automat{
private:
    ///functia de impartie in clase de echivalenta
    std::vector<std::vector<int>> submultimi( std::vector<int> clasa, std::vector<int> echiv)
    {
        std::map< std::vector<int>, std::vector<int>> subcl;
        std::vector<int> dest;
        std::vector<std::vector<int>> vector_clase_noi;
        for(int i=0;i<clasa.size();i++)
        {
            for(int j=0;j<alfabet;j++)
            {
                dest.push_back(echiv[matr[clasa[i]][j]]);
            }
            subcl[dest].push_back(clasa[i]);
        }
        for(auto i:subcl){
            vector_clase_noi.push_back(i.second);
        }
        return vector_clase_noi;
    }
public:
    DFA(){}
    //constructor care primeste matricea gata facuta
    DFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_,std::vector<std::vector<int>> matr_): Automat(Q_,q0_, alfabet_, sf_, matr_){}
    //constructor care initializeaza matricea de tranzitii cu -1
    DFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_):Automat(Q_,q0_,alfabet_,sf_){
        for(int i=0;i<Q_;i++)
        {
            for(int j=0;j<alfabet_;j++)
            {
                matr[i][j]=-1;
            }
        }
    }
    //citirea
    friend std::istream& operator>>(std::istream& in, DFA& dfa)
    {
        in>>dfa.Q>>dfa.q0>>dfa.alfabet;
        int aux;
        in>>aux;
        for(int i=0;i<aux;i++)
        {
            int x;
            in>>x;
            dfa.sf.push_back(x);
        }
        in>>aux;
        for(int i=0;i<aux;i++) {
            int stare, litera, dest;
            in >> stare >> dest >> litera;
            dfa.matr[stare][litera] = dest;
        }
        return in;
    }
    //afisarea
    friend std::ostream& operator<<(std::ostream& out, DFA dfa){
        for(int i=0;i<dfa.Q;i++)
        {
            for(int j=0;j<dfa.alfabet;j++)
            {
                if(dfa.matr[i][j]!=0)
                {
                    out << "Din starea "<< i<< " in starea "<< dfa.matr[i][j]<<" cu litera "<<j<< "\n";
                }
            }
        }

        return out;
    }
    DFA minimizare();
};

DFA DFA::minimizare(){
    /// 1. verific daca e automatul complet:
    bool complet=true;
    for(int i=0;i<Q;i++)
    {
        for(int j=0;j<alfabet;j++)
        {
            if(matr[i][j]==-1)
            {
                complet=false;
            }
        }
    }
    if(!complet)
    {
        Q++; //adaugam starea imposibil
        matr.push_back(std::vector<int>(alfabet,-1));
        for(int i=0;i<Q;i++)
        {
            for(int j=0;j<alfabet;j++)
            {
                if(matr[i][j]==-1)
                {
                    matr[i][j]=Q-1; //ducem toate muchiile care nu exista in starea imposibil
                }
            }
        }
    }

    /// 2.  eliminam starile inaccesibile din starea initiala
    //fac parcurgere pe graf (bfs) ca sa vad in ce stari ajung din starea initiala
    //le salvez in vectorul de stari "relevante"
    std::queue<int> coada;
    bool visited[Q];
    for(int i=0;i<Q;i++){
        visited[i]=false;
    }

    coada.push(q0);
    visited[q0]=true;
    while(!coada.empty())
    {
        int stare=coada.front();
        coada.pop();
        for(int litera=0;litera<alfabet;litera++)
        {
            visited[matr[stare][litera]]=true;

            if(!visited[matr[stare][litera]])
                coada.push(matr[stare][litera]);
        }
    }

    ///renumerotam si refacem matricea de adiacenta

    std::vector<int> relevante;
    for(int i=0;i<Q;i++)
    {
        if(visited[i]){
            relevante.push_back(i);//starile accesibile
        }
    }
    ///reatribuire
    int Q_nou=relevante.size();

    std::vector<int> sf_noi;

    std::vector<std::vector<int>> matr_noua;
    for(int i=0;i<Q_nou;i++)
    {
        matr_noua.push_back(matr[relevante[i]]);
        //daca nodul este stare finala, il adaugam la noile stari finale
        for(int j=0;j<sf.size();j++)
        {
            if(relevante[i]==sf[j])
            {
                sf_noi.push_back(i);
            }
        }
    }

    ///redefinire matrice de stari
    matr=matr_noua;
    Q=Q_nou;
    sf=sf_noi;
    //////**********/////

    /// 3.  Construim clasele de echivalenta
    std::vector<std::vector<int>> clase(Q); // matrice de clase de echivalenta
    std::vector<int> echiv(Q,-1); //fiecare stare cu clasa in care se afla
    for(int i=0;i<sf.size();i++)
    {
        echiv[sf[i]]=0; // punem toate starile finale intr o clasa
        clase[0].push_back(sf[i]);
    }
    for(int i=0;i<Q;i++)
    {
        if(echiv[i]==-1)
        {
            echiv[i]=clase.size(); //punem toate celelalte stari in o a doua clasa
            clase[1].push_back(i);
        }
    }
    bool schimbare=false;
    do //cat timp se mai creeaza subclase noi, continuam
    {
        std::vector<std::vector<int>> subclase;
        schimbare=false;
        for(int i=0; i<clase.size();i++)
        {
            subclase=submultimi(clase[i], echiv); //trecem la urmatoarea impartire pe clase
            if(subclase.size()>1) //daca clasa e impartita in cel putin alte doua clase noi, s a produs o schimbare si ramanem in bucla
            {
                schimbare=true;
            }
        }
        for(int i=0;i<subclase.size();i++)
        {
            for(int j=0;j<subclase[i].size();j++)
            {
                echiv[subclase[i][j]]=i;
            }
        }
        clase=subclase;
    }
    while(schimbare);
    return *this; // returnam un DFA minimizat
}

class NFA:public Automat{
public:
    NFA(){}
    NFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_):Automat(Q_,q0_,alfabet_,sf_){} //constructor

    ///citire
    friend std::istream& operator>>(std::istream& in, NFA& nfa)
    {
        in>>nfa.Q>>nfa.q0>>nfa.alfabet;
        nfa.matr.resize(nfa.Q,std::vector<int>(nfa.alfabet,0));
        int aux;
        in>>aux;
        for(int i=0;i<aux;i++)
        {
            int x;
            in>>x;
            nfa.sf.push_back(x);
        }
        in>>aux;
        for(int i=0;i<aux;i++)
        {
            int stare, litera, dest;
            in >> stare >> dest >> litera;
            nfa.matr[stare][litera] |= 1 << dest;
        }
        return in;
    }

    DFA transform_in_DFA(); //declar functia de transformare (retureaza un obiect tip DFA)
};

DFA NFA::transform_in_DFA() {
    std::queue<int> coada;
    int nr_stari_noi= 1<<Q; //numarul nou de stari va fi de 2^Q (nr vechi de stari)
    std::vector<std::vector<int>> matr_noua(nr_stari_noi, std::vector<int>(alfabet,-1));

    bool visited[nr_stari_noi];
    for(int i=0;i<nr_stari_noi;i++)
    {
        visited[i]=false;
    }
    //luam nodurile pe rand si aflam in ce stare noua ajung
    //folosim masti pe biti pentru a crea submultimile (indicii noilor stari)
    //facem o parcurgere pe noul graf, cu noile stari
    int stinit=1<<q0;
    coada.push(stinit);
    visited[stinit]=true;
    while(!coada.empty())
    {
        int stare=coada.front();
        coada.pop();
        for(int litera=0;litera<alfabet;litera++)
        {
            int stare_noua=0; // 0 e neutru la "sau" pe biti
            for(int i=0;i<Q;i++)
            {
                if((stare&(1<<i))!=0)
                {
                    stare_noua|= matr[i][litera]; //reuniune de multimi
                }
            }
            matr_noua[stare][litera]=stare_noua; // construim matricea noua
            if(!visited[stare_noua])
            {
                visited[stare_noua]=true;
                coada.push(stare_noua);
            }
        }
    }
    int mascasf=0;
    for(int i=0;i<sf.size();i++)
    {
        mascasf|= (1<<sf[i]); //avem o submultime cu starile finale
    }
    std:: vector<int> sf_noi;
    for(int i=0;i<nr_stari_noi;i++)
    {
        if(visited[i] && (mascasf & i)!=0)
        {
            sf_noi.push_back(i);
        }
    }
    DFA dfa_transformat(nr_stari_noi, stinit, alfabet, sf_noi, matr_noua); //obiect dfa pe care apoi il returnam
    return dfa_transformat;
}

int main() {
    freopen("input.txt","r",stdin);
    NFA nfa;
    std::cin>>nfa;
    DFA dfa_transformat=nfa.transform_in_DFA();
    std::cout<<dfa_transformat;
    DFA dfa_minimizat=dfa_transformat.minimizare();
    std::cout<<"\n\n\n"<<dfa_minimizat;
    return 0;
}

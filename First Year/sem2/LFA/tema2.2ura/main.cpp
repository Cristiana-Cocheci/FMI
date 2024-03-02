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
        Q(Q_), q0(q0_), alfabet(alfabet_), sf(sf_), matr(Q, std::vector<int>(alfabet,0)){}
    Automat(int Q_, int q0_, int alfabet_, std::vector<int> sf_,std::vector<std::vector<int>> matr_):
        Q(Q_), q0(q0_), alfabet(alfabet_), sf(sf_), matr(matr_){}
};
class DFA:public Automat{
private:
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
    DFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_,std::vector<std::vector<int>> matr_): Automat(Q_,q0_, alfabet_, sf_, matr_){}
    DFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_):Automat(Q_,q0_,alfabet_,sf_){
        for(int i=0;i<Q_;i++)
        {
            for(int j=0;j<alfabet_;j++)
            {
                matr[i][j]=-1;
            }
        }
    }
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
            in >> stare >> litera >> dest;
            dfa.matr[stare][litera] = dest;
        }
        return in;
    }
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
    ///verific daca e automatul complet:
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
    /*
    ///eliminam starile inaccesibile din starea initiala
    std::queue<int> coada;
    bool visited[Q];
    coada.push(q0);
    visited[q0]=true;
    while(!coada.empty())
    {
        int stare=coada.front();
        coada.pop();
        for(int litera=0;litera<alfabet;litera++)
        {
            visited[matr[stare][litera]]=true;
            coada.push(matr[stare][litera]);
        }
    }
    std::vector<int> relevante;
    for(int i=0;i<Q;i++)
    {
        if(visited[i]){
            relevante.push_back(i);
        }
    }

     */


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
    do
    {
        std::vector<std::vector<int>> subclase;
        schimbare=false;
        for(int i=0; i<clase.size();i++)
        {
            subclase=submultimi(clase[i], echiv); //trecem la urmatoarea impartire pe clase
            if(subclase.size()>1)
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
    return *this;
}

class NFA:public Automat{
public:
    NFA(){}
    NFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_):Automat(Q_,q0_,alfabet_,sf_){}

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

    DFA transform_in_DFA();
};

DFA NFA::transform_in_DFA() {
    std::queue<int> coada;
    int nr_stari_noi= 1<<Q;
    std::vector<std::vector<int>> matr_noua(nr_stari_noi, std::vector<int>(alfabet,-1));

    bool visited[nr_stari_noi];
    for(int i=0;i<nr_stari_noi;i++)
    {
        visited[i]=false;
    }
    int stinit=1<<q0;
    coada.push(stinit);
    visited[stinit]=true;
    while(!coada.empty())
    {
        int stare=coada.front();
        coada.pop();
        for(int litera=0;litera<alfabet;litera++)
        {
            int stare_noua=0;
            for(int i=0;i<Q;i++)
            {
                if((stare&(1<<i))!=0)
                {
                    stare_noua|= matr[i][litera];
                }
            }
            matr_noua[stare][litera]=stare_noua;
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
        mascasf|= (1<<sf[i]);
    }
    std:: vector<int> sf_noi;
    for(int i=0;i<nr_stari_noi;i++)
    {
        if(visited[i] && (mascasf & i)!=0)
        {
            sf_noi.push_back(i);
        }
    }
    DFA dfa_transformat(nr_stari_noi, stinit, alfabet, sf_noi, matr_noua);
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

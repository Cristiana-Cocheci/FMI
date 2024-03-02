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
        std::cerr<< "nr de stari:"<<dfa.Q;
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
};
class NFA:public Automat{
public:
    NFA(){}
    NFA(int Q_, int q0_, int alfabet_, std::vector<int> sf_):Automat(Q_,q0_,alfabet_,sf_){}

    friend std::istream& operator>>(std::istream& in, NFA& nfa)
    {
        in>>nfa.Q>>nfa.q0>>nfa.alfabet;
        int aux;
        std::cerr<<"nr stari "<<nfa.Q<<"\nstare init"<<nfa.q0<<"\nsize alf "<<nfa.alfabet;
        in>>aux;
        for(int i=0;i<aux;i++)
        {
            int x;
            in>>x;
            nfa.sf.push_back(x);
            std::cerr<<"nod final "<<i<<nfa.sf[i];
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
    std::vector<std::vector<int>> matr_noua;
    std::queue<int> coada;
    int nr_stari_noi= 1<<Q;
    bool visited[nr_stari_noi];
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
    std::cout<<nfa.transform_in_DFA();

    return 0;
}

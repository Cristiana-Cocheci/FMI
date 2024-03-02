#include <iostream>
#include <bits/stdc++.h>
//determinist


class Automat_push_down{
protected:
    int Q; //nr de stari
    int q0; //stare initiala
    int alfabet; // alfabetul e format din numere de la 0 la alf
    int alfabet_stiva; //alfabetul stivei format din numere de la 0 la alf_stiva //-1==simbol final
    std::vector<int> sf; //starile finale
    //std::vector<std::map<std::pair<int,int>, std::pair<int,std::string>>> tranz;
     //tranzitie[stare_curenta]([litera_curenta][simbol de pe stiva])== (stare_noua, simbol pe stiva)
    std::vector<std::vector<std::pair<std::vector<int>, std::string>>> tranz; //[lit_curenta,simbol,stiva,stare_noua]+ cuvat
    std::stack<int> st;

public:
    Automat_push_down(){}
    Automat_push_down(int Q_, int q0_, int alfabet_, int _alf_s, std::vector<int> sf_, std::vector<std::pair<int,std::string>> tranz_):
        Q(Q_), q0(q0_), alfabet(alfabet_),alfabet_stiva(_alf_s), sf(sf_){}
    //citire
    friend std::istream& operator>>(std::istream& in, Automat_push_down& PDA)
    {
        in>>PDA.Q>>PDA.q0>>PDA.alfabet>>PDA.alfabet_stiva;
        int aux;
        in>>aux; //nr stari finale
        for(int i=0;i<aux;i++)
        {
            int x;
            in>>x;
            PDA.sf.push_back(x);
        }
        //PDA.tranz.resize(PDA.Q,std::map<std::pair<int,char>, std::pair<int,std::string>>(PDA.alfabet));
        /*for(int i=0;i<PDA.Q;i++){
            std::map<std::pair<int,int>, std::pair<int,std::string>> aux;
            PDA.tranz.push_back(aux);
        }*/
        PDA.tranz.resize(PDA.Q,std::vector<std::pair<std::vector<int>, std::string>>(PDA.alfabet));


        in>>aux; //nr tranzittii
        for(int i=0;i<aux;i++) {
            int stare, dest;
            char litera_curenta, simbol_stiva;
            std::string cuv_stiva; //$ SIMBOL SPECIAL, LAMBDA
            in >> stare >> litera_curenta >> simbol_stiva >> dest >> cuv_stiva;
            //std::cout << cuv_stiva;
            /*std::pair<int,int> p0(litera_curenta,simbol_stiva);
            std::pair<int,std::string> p1(dest,cuv_stiva);
            std::map<std::pair<int,int>, std::pair<int,std::string>> m_aux={{p0,p1}};*/
            std::vector<int> v;
            v.push_back(litera_curenta-'a');
            if(simbol_stiva=='$'){simbol_stiva=-1;}
            v.push_back(simbol_stiva);
            v.push_back(dest);
            PDA.tranz[stare].push_back(make_pair(v,cuv_stiva));
        }
        return in;
    }
    friend std::ostream& operator<<(std::ostream& out, const Automat_push_down& PDA)
    {
        out<<PDA.Q<<PDA.q0<<PDA.alfabet<<PDA.alfabet_stiva;

        return out;
    }
    int dfs(std::string cuvant, int poz, int stare);
    bool acceptare(std::string cuvant);
};

int Automat_push_down::dfs(std::string cuvant, int poz, int stare)
{
    if(poz==cuvant.size())
    {
        return stare;
    }
    int litera_curenta=cuvant[poz]-'a';
    for(int i=0;i<alfabet;i++)
    {
        int lit_c=tranz[stare][i].first[0];
        int lit_st=tranz[stare][i].first[1];
        if(lit_c==litera_curenta && lit_st==st.top())
        {
            int stare_noua=tranz[stare][i].first[2];

            st.pop();
            //adaugam ce e nou in stiva
            std::string cuv_nou=tranz[stare][i].second;
            if(cuvant=="LAMBDA"){
                st.pop();
            }
            else{
                for(int j=cuv_nou.size()-1;j>=0;j--){
                    if(static_cast<int>(cuv_nou[j])=='$'){
                        st.push(-1);
                    }
                    else{
                        st.push(cuv_nou[i]-'a');
                    }

                }
            }

            return(this->dfs(cuvant,poz+1,stare_noua));
        }
    }

}

bool Automat_push_down::acceptare(std::string cuvant)
{
    st.push(-1); //adaugam simbol de oprire in stiva
    int sff=this->dfs(cuvant, 0, q0);
    for(int i=0; i<sf.size();i++){
        if(sf[i]==sff && st.size()==1 && st.top()==-1) //acceptare cu stiva goala si stare finala
        {
            return true;
        }
    }
    return false;

}

int main()
{
    Automat_push_down PDA;
    std::cin>> PDA;
    std::cout<<PDA;

    std::string cuvant;
    std::cout<<PDA.acceptare(cuvant);
    return 0;
}



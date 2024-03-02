#include <iostream>
#include <bits/stdc++.h>
//determinist


class Automat_push_down{
private:
    int Q; //nr de stari
    int q0; //stare initiala
    int alfabet; // alfabetul e format din numere de la 0 la alf
    int alfabet_stiva; //alfabetul stivei format din numere de la 0 la alf_stiva //-1==simbol final
    std::vector<int> sf; //starile finale
    std::vector<std::vector<std::vector<std::vector<std::pair<int,std::string>>>>> tranz;
     //tranzitie[stare_curenta]([litera_curenta][simbol de pe stiva])== (stare_noua, simboluri pe stiva)
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

        PDA.tranz.resize(PDA.Q,std::vector<std::vector<std::vector<std::pair<int,std::string>>>>(PDA.alfabet,std::vector<std::vector<std::pair<int,std::string>>>(PDA.alfabet_stiva,std::vector<std::pair<int,std::string>>(0))));


        in>>aux; //nr tranzittii
        for(int i=0;i<aux;i++) {
            int stare, dest;
            char litera_curenta, simbol_stiva;
            std::string cuv_stiva; //$ SIMBOL SPECIAL, LAMBDA
            in >> stare >> litera_curenta >> simbol_stiva >> dest >> cuv_stiva;

            if(litera_curenta=='L'){litera_curenta=PDA.alfabet-1;}
            else {litera_curenta=litera_curenta-'a';}
            if(simbol_stiva=='$'){simbol_stiva=PDA.alfabet_stiva-1;}
            else{simbol_stiva-='A';}
            std::pair<int,std::string> p=make_pair(dest,cuv_stiva);

            PDA.tranz[stare][litera_curenta][simbol_stiva].push_back(p);
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
        if(tranz[stare][alfabet-1][alfabet_stiva-1].size()!=0 && st.top()==alfabet_stiva-1){
            st.pop();

            std::string cuv_nou=tranz[stare][alfabet-1][alfabet_stiva-1][0].second;

            if(cuvant=="LAMBDA"){
                st.pop();
            }
            else{
                for(int j=cuv_nou.size()-1;j>=0;j--){
                    if(static_cast<int>(cuv_nou[j])=='$'){
                        st.push(alfabet_stiva-1);
                    }
                    else{
                        st.push(cuv_nou[j]-'A');
                    }

                }
            }
            return tranz[stare][alfabet-1][alfabet_stiva-1][0].first;
        }
        return stare;
    }
    int litera_curenta=cuvant[poz]-'a';
    int simbol_stiva=st.top();
    //std::cout<<poz<<" "<<stare<<" "<<(char)(st.top()+'A')<<"\n";
    for(int i=0;i<tranz[stare][litera_curenta][simbol_stiva].size();i++)
    {
        int stare_noua=tranz[stare][litera_curenta][simbol_stiva][i].first;

        st.pop();
        //adaugam ce e nou in stiva
        std::string cuv_nou=tranz[stare][litera_curenta][simbol_stiva][i].second;
        if(cuv_nou=="LAMBDA"){
            st.pop();
        }
        else{
            for(int j=cuv_nou.size()-1;j>=0;j--){
                if(static_cast<int>(cuv_nou[j])=='$'){
                    st.push(alfabet_stiva-1);
                }
                else{
                    st.push(cuv_nou[j]-'A');
                }

            }
        }
        return(this->dfs(cuvant,poz+1,stare_noua));

    }

}

bool Automat_push_down::acceptare(std::string cuvant)
{
    st.push(alfabet_stiva-1); //adaugam simbol de oprire in stiva

    int sff=this->dfs(cuvant, 0, q0);
    for(int i=0; i<sf.size();i++){
        if(sf[i]==sff && st.size()==1 && st.top()==alfabet_stiva-1) //acceptare cu stiva goala si stare finala
        {
            return true;
        }
    }
    return false;

}

int main()
{
    freopen("input.txt","r",stdin);
    Automat_push_down PDA;
    std::cin>> PDA;

    std::string cuvant;
    std::cin>> cuvant;
    std::cout<<PDA.acceptare(cuvant);
    return 0;
}

//determinist

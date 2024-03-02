#include <iostream>
#include<vector>
#include<string>

int nr_neterminali, nr_terminali, p;
std::vector<char> N, T;
std::string cuvant;

int indice_n(char c)
{
    for(int i=0;i<nr_neterminali;i++){
        if(c==N[i]){
            return i;
        }

    }
}
int indice_t(char c)
{
    for(int i=0;i<nr_terminali;i++){
        if(c==T[i]){
            return i;
        }

    }
}


int main()
{
    freopen("intrare.in","r",stdin);
    //citire
    std::cin>>nr_neterminali;
    for(int i=0;i<nr_neterminali;i++)
    {
        char net;
        std::cin>> net;
        N.push_back(net);
    }
    std::cin>>nr_terminali;
    for(int i=0;i<nr_terminali;i++)
    {
        char t;
        std::cin>> t;
        T.push_back(t);
    }
    ///
    std::vector<std::vector<std::pair<int,int>>> relatii(nr_neterminali,std::vector<std::pair<int,int>>());
    std::vector<std::vector<bool>> NT(nr_neterminali,std::vector<bool>(nr_terminali,0));
    std::cin>> p;
    for(int i=0;i<p;i++)
    {
        int type;
        char n;
        std::cin>>type>>n;
        if(type==0)
        {
            char a,b;
            std::cin>>a>>b;
            relatii[indice_n(n)].push_back(std::make_pair(indice_n(a),indice_n(b)));
        }
        else
        {
            char a;
            std::cin>>a;
            NT[indice_n(n)][indice_t(a)]=1;
        }

    }
    ///afisare limbaj
    for(int i=0;i<nr_neterminali;i++){
        std::cout<< N[i]<<" -> ";
        for(int j=0;j<relatii[i].size();j++)
        {
            std::cout<< N[relatii[i][j].first]<<N[relatii[i][j].second]<<" | ";
        }
        for(int j=0;j<NT[i].size();j++)
        {
            if(NT[i][j]==1)
            {
                std::cout<<T[j]<<" | ";
            }
        }

        std::cout<<"\n";
    }
    ///

    std::cin>>cuvant;
    int lungime=cuvant.size();
    std::vector<std::vector<std::vector<int>>> dp(lungime+1, std::vector<std::vector<int>>(lungime+1,std::vector<int>(1,-1)));

    for(int i=0;i<=lungime;i++)
    {
        for(int net=0;net<nr_neterminali;net++)
        {
            if(NT[net][indice_t(cuvant[i])]==1)
            {
                dp[i][i].push_back(net);
            }
        }
    }
    /* VERIFICARE DIAG PRINCIPALA - DA
    for(int i=0;i<=lungime;i++){
        for(int j=0;j<=lungime;j++){
            std::cout<<dp[i][j].size()<<"\n";
            for(int h=1;h<dp[i][j].size();h++){
                std::cout<<i<<j<<h<<N[dp[i][j][h]]<<" ";
            }
        }
        std::cout<<"\n";
    }
    */

    for(int l=1;l<=lungime;l++)
    {
        for(int i=0;i<lungime-l;i++)
        {
            int j=i+l;
            for(int k=i;k<j;k++)
            {
                for(int net=0;net<nr_neterminali;net++)
                {
                    for(int aux=0;aux<relatii[net].size();aux++)
                    {
                        //std::cerr<<
                        int a=(relatii[net][aux].first);
                        int b=(relatii[net][aux].second);
                        //daca a in dp[i][k] si b in dp[k+1][j]
                        bool oka=false,okb=false;
                        for(int h=0;h<dp[i][k].size();h++){
                            if(dp[i][k][h]==a){
                                oka=true;
                            }
                        }
                        for(int h=0;h<dp[k+1][j].size();h++){
                            if(dp[k+1][j][h]==b){
                                okb=true;
                            }
                        }

                        if(oka && okb)
                        {
                            dp[i][j].push_back(net);
                        }
                    }
                }
            }
        }

    }
    int s=indice_n('S');
    bool da=false;
    //VERIFICARE MATRICE -BUN
    /*
    for(int i=0;i<=lungime;i++){
        for(int j=0;j<=lungime;j++){
            for(int h=1;h<dp[i][j].size();h++){
                std::cout<<i<<j<<" "<<N[dp[i][j][h]]<<"\n";
            }
        }
        std::cout<<"\n";
    }*/

    int j=lungime-1;
    for(int i=0;i<=lungime;i++)
    {
        for(int h=1;h<dp[i][j].size();h++){
            if(N[dp[i][j][h]]=='S'){
                da=true;
            }
        }
    }
    std::cout<<da;
    return 0;
}

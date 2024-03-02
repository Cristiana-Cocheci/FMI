#include <bits/stdc++.h>

using namespace std;

vector<int> shortestPath(int N, int X, int Y) {
    if(X>Y){
        int aux=Y;
        Y=X;
        X=Y;
    }
    int mij = (X+Y)/2;
    vector<int> distante(N+1,0);
    for(int nod =1; nod<=N; nod++){
            for(int vec = 1; vec <=N; vec++){
                cout<<distante[vec]<<" ";
            }
    cout<<"\n";
        if(nod<mij){
            for(int vec = nod+1; vec<=mij; vec++){
                distante[vec-nod]++;
                cout<<nod<<" "<< vec<<" "<< vec-nod<<"\n";
                cout<<distante[vec-nod]<<"\n";
            }
            for(int vec = mij+1; vec <=N; vec++){
                distante[X + abs(Y-vec)]++;
                 cout<<nod<<" "<< vec<<" "<< X + abs(Y-vec)<<"\n";
                 cout<<distante[X + abs(Y-vec)]<<"\n";
            }
        }
        else{
            for(int vec = nod+1; vec <=N; vec++){
                distante[X + abs(Y-vec)]++;
                 cout<<nod<<" "<< vec<<" "<< X + abs(Y-vec)<<"\n";
                 cout<<distante[X + abs(Y-vec)]<<"\n";
            }
        }
    }
    return distante;
}


int main()
{
    int N,X,Y;
    cin>>N>>X>>Y;
    vector<int> v = shortestPath(N,X,Y);
    for(int vec = 1; vec <=N; vec++){
                cout<<v[vec]<<" ";
            }
    return 0;
}

/*
#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);




vector<int> shortestPath(int N, int X, int Y) {
    if(X>Y){
        int aux=Y;
        Y=X;
        X=Y;
    }
    int mij = (X+Y)/2;
    vector<int> distante(N+1,0);
    for(int nod =1; nod<=N; nod++){
        if(nod<mij){
            for(int vec = nod+1; vec<=mij; vec++){
                distante[vec-nod]++;
                cout<<nod<<" "<< vec<<" "<< vec-nod<<"\n";
                cout<<distante[vec-nod]<<"\n";
            }
            for(int vec = mij+1; vec <=N; vec++){
                distante[X + abs(Y-vec)]++;
                 cout<<nod<<" "<< vec<<" "<< X + abs(Y-vec)<<"\n";
                 cout<<distante[vec-nod]<<"\n";
            }
        }
        else{
            for(int vec = nod+1; vec <=N; vec++){
                distante[X + abs(Y-vec)]++;
                 cout<<nod<<" "<< vec<<" "<< vec-nod<<"\n";
                 cout<<distante[vec-nod]<<"\n";
            }
        }
    }
    return distante;
}


int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string N_temp;
    getline(cin, N_temp);

    int N = stoi(ltrim(rtrim(N_temp)));

    string X_temp;
    getline(cin, X_temp);

    int X = stoi(ltrim(rtrim(X_temp)));

    string Y_temp;
    getline(cin, Y_temp);

    int Y = stoi(ltrim(rtrim(Y_temp)));

    vector<int> result = shortestPath(N, X, Y);

    for (size_t i = 0; i < result.size(); i++) {
        fout << result[i];

        if (i != result.size() - 1) {
            fout << "\n";
        }
    }

    fout << "\n";

    fout.close();

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}
*/

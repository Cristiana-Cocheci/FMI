#include <iostream>
#include <bits/stdc++.h>
/*
4 4
1 0
2 0
3 1
3 2
*/
using namespace std;

int main()
{
    vector<vector<int>> prerequisites;
    int n,numCourses;
    cin>>numCourses>>n;
    vector<int> grad_interior(numCourses), rezultat, vizitat(numCourses);
    queue<int> coada;
    for(int i=0;i<n;i++){
        vector<int> temp(2);
        cin>>temp[0]>>temp[1];
        prerequisites.push_back(temp);
        //cout<<prerequisites[i][0]<<" "<<prerequisites[i][1]<<"\n";
    }
        std::map<int,std::vector<int>> mapp;
        /*for(int i=0;i<mapp.size();i++){
            mapp[i]=vector<int>();
        }*/
        for(int i=0;i<numCourses;i++){
            int x=prerequisites[i][1], y=prerequisites[i][0];
            mapp[x].push_back(y);
            grad_interior[y]++;
        }
       /* afisare mapp
        for(int i=0;i<numCourses;i++){
            cout<<"\n"<<i<<" "<<mapp[i].size();
            for(int j=0;j<mapp[i].size();j++){
                cout<<mapp[i][j]<<" ";
            }
        }*/
        for(int i=0;i<numCourses;i++){
            if(grad_interior[i]==0){
                coada.push(i);
                vizitat[i]=1;
            }
        }
        int ok=0;
        while(coada.empty()==0){
            int nod=coada.front();
            rezultat.push_back(nod);
            coada.pop();
            //cout<<mapp[nod].size()<<" ";
            for(int i=0;i<mapp[nod].size();i++){
                //cout<<mapp[nod][i]<<" ";
                grad_interior[mapp[nod][i]]--;
            }
            for(int i=0;i<numCourses;i++){
                //cout<<vizitat[i]<<" "<<grad_interior[i]<<"\n";
                if(grad_interior[i]==0 && vizitat[i]==0){
                    coada.push(i);
                    vizitat[i]=1;
                }
            }

        }
        for(int i=0;i<numCourses;i++){
            cout<<rezultat[i]<<" ";
        }

}


/*
sortare topologica
 tinem minte gradul interior al nodurilor
 for noduri:
    gasim noduri cu grad interior zero
    le bagam in coada
 cat timp coada nu e vida
    luam primul nod din coada
    scadem gradul interior al tuturor vecinilor
    for noduri_ramase:
        punem toate nodurile de grad zero in coada

nu se poate sorta topologic daca are cicluri graful
*/


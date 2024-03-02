#include <iostream>
#include <ctime>
#include <cstdlib>

class Xsi0{
private:
    int board[3][3];
    int playerturn;
    void initboard();
    int checkwin();
    void playermove();
    bool checkdraw();
    bool checkresult();
public:
    Xsi0();
    void playgame();
};

Xsi0:: Xsi0()
{
    for(int i=0; i<3;i++)
    {
        for(int j=0; j<3;j++)
        {
            board[i][j]=0;
        }
    }
    srand(time(0));
    playerturn = rand()%2+1;
}
void Xsi0::playgame() {
    while(1)
    {
        system("cls");
        initboard();
        playermove();
        if(checkresult())
        {
            break;
        }
    }
    std::cout << "\n";
}

void Xsi0::initboard() {
    std::cout << "Player 1(1) - Player 2(2) "<<"\n\n";
    std::cout << "Turn: Player "<< playerturn << "\n\n";
    for(int i=0;i<3;i++)
    {
        std::cout<<" ";
        for(int j=0;j<3;j++){
            std::cout <<board[i][j];
            if(j==2)
                continue;
            std::cout<< " | ";
        }
        if(i==2)
        {
            continue;
        }
        std::cout<<"\n___|___|___\n   |   |   \n";
    }
}

void Xsi0::playermove() {
    int row, col;
    bool correctmove=false;
    std::cout<<"\n\nMake your move!\n";
    while(!correctmove)
    {
        std::cout<<"Enter Row (0-2): ";
        std::cin>>row;
        std::cout<<"Enter Column (0-2): ";
        std::cin>>col;
        if(-1<row && row<3 && -1<col && col<3)
        {
            if(board[row][col]==0)
            {
                board[row][col]=playerturn;
                correctmove= true;
                playerturn++;
                if(playerturn>2)playerturn=1;
            }
        }
        if(!correctmove)
        {
            std::cout<< "Wrong Input, try again\n";
        }

    }
}

bool Xsi0::checkresult() {
    int check=checkwin();
    switch ((check)) {
        case 1:
            system("cls");
            initboard();
            std::cout<<"\n\nPlayer1 won!  ;)\n\n";
            return true;
        case 2:
            system("cls");
            initboard();
            std::cout<<"\n\nPlayer2 won!  ;)\n\n";
            return true;
        case -1:
            if(checkdraw())
            {
                system("cls");
                initboard();
                std::cout<<"\n\nIt's a draw :p\n\n";
                return true;
            }
            break;
    }
    return false;
}
int Xsi0::checkwin() {
    for(int player=1;player<=2;player++)
    {
        for(int i=0;i<=2;i++)
        {
            if(board[i][0]==player && board[i][1]==player && board[i][2]==player)
            {
                return player;
            }
            if(board[0][i]==player && board[1][i]==player && board[2][i]==player) {
                return player;
            }
        }
        if(board[0][0]==player && board[1][1]==player && board[2][2]==player)
        {
            return player;
        }
        if(board[0][2]==player && board[1][1]==player && board[2][0]==player)
        {
            return player;
        }
    }
    return -1;
}

bool Xsi0::checkdraw() {
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<3;j++)
        {
            if(board[i][j]==0)
            {
                return false;
            }
        }
    }
    return true;
}

int main() {
    Xsi0 obj;
    obj.playgame();
    system("pause");
    return 0;
}

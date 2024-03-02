/*
class Game{
private:
    bool quit;
    int noLanes;
    int mapWidth;
    int score;
    Player player;
    std::vector <Lane> map;
public:
    Game(int w=20, int h=10, int score_=0)
    {
        score=score_;
        noLanes=h;
        mapWidth=w;
        quit=false;
        //map=std::vector<Lane>(h);

        for(int i=0;i<noLanes;i++) {
            map.push_back(Lane(mapWidth));
        }
        player= Player(mapWidth, noLanes);

    }
    //operator <<
    friend std::ostream& operator<<(std::ostream& out, const Game& g){
        out<<"Date de baza joc: numar benzi-"<<g.noLanes<<", latimea drumului-"<<g.mapWidth<<", scorul-"<<g.score<<"\n";
        return out;
    }
    void draw()
    {
        //system("cls");
        rlutil::cls();
        for(int i=0; i<noLanes; i++)
        {
            for(int j=0; j<mapWidth;j++)
            {
                if(i==0 && (j==0 || j==mapWidth-1)){std::cout<<"-";}
                if(i==0 && (j==1 || j==mapWidth-2)){std::cout<<"S";}
                if(i==noLanes-1 && (j==0 || j==mapWidth-1)){std::cout<<"F";}
                if(map[i].trackPosition(j) && i>0 && i<noLanes-1)
                { std::cout << "c "; }
                else if(player.getX()==j && player.getY()==i)
                { std::cout <<"P "; }
                else
                { std::cout<<" "; }
            }
            std::cout<<"\n";
        }
        std::cout <<"Score "<<score<<"\n";
    }
    void input()
    {
        
        char current = std::tolower(rlutil::nb_getch());
        if(current=='a'){player.MoveLeft();}
        if(current=='w'){player.MoveDown();}
        if(current=='s'){player.MoveUp();}
        if(current=='d'){player.MoveRight();}
        if(current=='q'){quit=true;}
    }
    void logic(){
        for(int i=1;i<noLanes-1;i++)
        {
            if(std::rand()%10==1)
            {
                map[i].move();
            }
            if(map[i].trackPosition(player.getX()) && player.getY()==i) {
                quit = true;
                std::cout << "YOU LOSE ;-(\n";
            }
        }
        if(player.getY()==noLanes-1)
        {
            //quit=true;
            //std::cout<< "YOU WIN!!!!\n";
            score++;
            player.reset();
        }
    }
    void run()
    {
        while(!quit)
        {
            input();
            draw();
            logic();
            rlutil::msleep(100);
        }
    }
};
*/
#include <iostream>
#include <vector>
#include <deque>
#include "rlutil.h"
#include <ctime>

/*
class Lane
{
protected:
    std::deque<bool> cars;
    int direction=rand()%2;
public:
    Lane(int width=20)
    {
        for(int i=0; i<width;i++)
        {
            cars.push_front(false);
        }
    }
    virtual void move(){
        bool c; //masina
        if(rand()%10==1) //10% sanse sa intre o masina pe drum
            c=true;
        else
            c=false;
        if(direction==0){ //stanga-dreapta
            cars.push_front(c);
        }
        else { //dreapta-stanga
            cars.push_back(c);
        }
        cars.pop_back();
    }
    bool trackPosition(int pos){return cars[pos];}
    friend std::ostream& operator<<(std::ostream& out, const Lane& l){
        out<<"Afisare dimensiune banda: ";
        out<<l.cars.size()<<"\n";
        return out;
    }
};
class fastLane : public Lane
{
public:
    fastLane(int _width):Lane(_width){};
    void move() override{
        bool c; //masina
        if(rand()%4==1) //25% sanse sa intre o masina pe drum
            c=true;
        else
            c=false;
        if(direction==0){ //stanga-dreapta
            cars.push_front(c);
        }
        else { //dreapta-stanga
            cars.push_back(c);
        }
        cars.pop_back();
    }
};*/
///*
class Lane
{
private:
    std::deque<bool> cars;
public:
    Lane(int width=20)
    {
        for(int i=0; i<width;i++)
        {
            cars.push_front(false);
        }
    }
    void move()
    {
        if(rand()%10==1) //10% sanse sa intre o masina pe drum
        {
            cars.push_front(true);
        }
        else
        {
            cars.push_front(false);
        }
        cars.pop_back();
    }
    bool trackPosition(int pos){return cars[pos];}

    //operator <<
    friend std::ostream& operator<<(std::ostream& out, const Lane& l){
        out<<"Afisare dimensiune banda: ";
        out<<l.cars.size()<<"\n";
        return out;
    }
};//*/
class Player{
private:
    int x,y, noLanes, mapWidth;
public:
    Player(int width=20, int height=10){x=width/2;y=0, noLanes=height, mapWidth=width;}
    Player(const Player& other): x(other.x),y(other.y), noLanes(other.noLanes), mapWidth(other.mapWidth){ std::cout<<"cc\n";};
    Player& operator=(const Player& other) {
        std::cout << "op=\n";
        x = other.x;
        y = other.y;
        noLanes = other.noLanes;
        mapWidth = other.mapWidth;
        return *this;
    }
    ~Player(){std::cout<<"destr\n";}

    int getX() const{return x;}
    int getY() const{return y;}
    void MoveLeft(){if(x>0)x--;}
    void MoveRight(){if(x<mapWidth-1)x++;}
    void MoveUp(){if(y<noLanes-1)y++;}
    void MoveDown(){if(y>0)y--;}
    void reset(){y=0;x=mapWidth/2;}

    //operator <<
    friend std::ostream& operator<<(std::ostream& out, const Player& p){
        out<<"Coordonatle x,y: "<<p.x<<" "<<p.y<<"\n";
        return out;
    }

};
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
            int fastL_chance= score/100;
            if(rand()%fastL_chance==0) //fast lane
            {
                map.push_back(Lane(mapWidth));
            }
            else{
                map.push_back(Lane(mapWidth));
            }

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
        /*system("cls");*/
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
        /*if(kbhit())
        {
            char current = getch();
            if(current=='a'){player.MoveLeft();}
            if(current=='w'){player.MoveDown();}
            if(current=='s'){player.MoveUp();}
            if(current=='d'){player.MoveRight();}
            if(current=='q'){quit=true;}
        }*/
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
            //if(std::rand()%10==1)
                map[i].move();
            if(map[i].trackPosition(player.getX()) && player.getY()==i) {
                quit = true;
                std::cout << "YOU LOSE ;-(\n";
            }
        }
        if(player.getY()==noLanes-1)
        {
            /*quit=true;
            std::cout<< "YOU WIN!!!!\n";*/
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

int main() {
    srand(time(nullptr));
    Game joc(30,5);
    joc.run();
    return 0;
}
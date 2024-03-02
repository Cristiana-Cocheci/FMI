var nume= prompt("Hai să jucăm X și 0. Cum te cheamă?");
var player= prompt("Bună, "+ nume+". Cu ce vrei să joci? X sau 0? X începe primul.");
if (player!='X' && player!='0'){
    player=prompt("Alegere invalida. Mai incearca!");
}
var tabla=[];
for(var i=1; i<11; i++){
    tabla.push("?");
}


function computer_move(){
    var r=Number.parseInt(Math.random()*10);
    while(!valid(r,99)){
        r=Number.parseInt(Math.random()*10);
    }
}

function game()
{
    var i=1;
    while(win()==false && draw()==false){
        if(player=='X' && i%2==1 || player=='0' && i%2==0){
            var poz_player=prompt(printtt()+"Unde vrei sa pui urmatorul semn?");
            if( !valid(poz_player, 1)){
                var poz_player=prompt(printtt()+"Alegeti o pozitie libera!");
            }
        }
        else{
            computer_move();
            alert(printtt());
        }
        var castig=win();
        if(castig!=false){
            if(castig==1 && player=='X' || castig==2 && player=='0'){
                alert("Bravo, "+nume+", ai castigat!");
            }
            else{
                alert("Pare rau, "+nume+", ai pierdut ;(");
            }
        }
        if(draw()){
            alert("Remiza!");
        }
        i++;
    }
}


function printtt(){
    var afisare="";
    for(var i=1;i<=9;i++){
        afisare+="| ";
        if(tabla[i]=="?"){
            afisare+=i+" ";
        }
        else{
            afisare+=tabla[i]+" ";
        }
        if(i%3==0){
            afisare+="|\n";
        }
    }
    return afisare;
}
function valid(poz_player,p){
    if(poz_player>0 && poz_player<10){
        if(tabla[poz_player]=="?"){
            var aux;
            if(p==1){
                aux=player;
            }
            else{
                if(player=='X'){
                    aux='0';
                }
                else{
                    aux='X';
                }
            }
            tabla[poz_player]=aux;
            return true;
        }
    }
    return false;
}

function win(){
    for(var i=1;i<=3;i++){
        if(tabla[i]==tabla[i+3] && tabla[i]==tabla[i+6] && tabla[i]==0){
            return 2;
        }
        if(tabla[i]==tabla[i+3] && tabla[i]==tabla[i+6] && tabla[i]=='X'){
            return 1;
        }
        if(tabla[i]==tabla[i+1] && tabla[i]==tabla[i+2] && tabla[i]==0){
            return 2;
        }
        if(tabla[i]==tabla[i+1] && tabla[i]==tabla[i+2] && tabla[i]=='X'){
            return 1;
        }
    }
    if(tabla[1]==tabla[5] && tabla[5]==tabla[9] && tabla[9]==0){
        return 2;
    }
    if(tabla[3]==tabla[5] && tabla[5]==tabla[7] && tabla[9]=='X'){
        return 1;
    }
    return false;
    
}

function draw(){
    for(var i=1;i<10;i++){
        if(tabla[i]=='?'){
            return false;
        }
    }
    return true;
}


jocuri=[{
    nume_j:nume,
    player_opt: player,
    printtt: printtt,
    tabla:tabla,
    not_over:not_over,
    turn: turn, computer_move: computer_move, check: check
    },
    {
    nume_j:nume,
    player_opt: player2,
    printtt: printtt,
    tabla:tabla,
    not_over:not_over,
    turn: turn, computer_move: computer_move, check: check
    }]
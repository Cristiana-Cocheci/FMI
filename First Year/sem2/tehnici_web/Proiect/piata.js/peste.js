/*
1-macrou
2-CodAtlantic
3-PesteSpada
*/
var maxnooffish=15;

function resize_body(){
    var body=document.getElementById("body");
    var h=window.innerHeight;
    document.body.style.height=h-100+'px';
    body.style.borderColor= "rgb(80, 63, 34)";
    body.style.borderStyle= "ridge";
}
function draw_water(nrows, ncols){
    var tbl=document.getElementById("acvariu");
    for(let i=0;i< nrows;i++){
        for (let j = 0; j < ncols; j++) {
            const cell = document.createElement("td");
            tbl.appendChild(cell);
          }
    }
}
function activateCell(n,color){
    var tbl=document.getElementById("acvariu");
    var cells=tbl.childNodes;
    cells[n].style.background=color;
}
function wave(nrows){
    var tbl=document.getElementById("acvariu");
    var cells=tbl.childNodes;
    for(let i = 0; i <cells.length; i++)
    {
        cells[i].style.animationPlayState='running';
        cells[i].style.animationDelay=(i%nrows)*0.07+ 's';
    }
}
function stopWave(){
    var tbl=document.getElementById("acvariu");
    var cells=tbl.childNodes;
    for(let i = 0; i <cells.length; i++)
    {
        cells[i].style.animationPlayState='paused';
    }
}

const pesti=[
    {
        "nume" : "Macrou",
        "descriere" : "Macrou este un nume comun dat peștilor pelagici care provin din familia Scombridae. Se găsesc în mările tropicale și temperate din întreaga lume și trăiesc în larg sau de-a lungul coastei. Au dungi verticale negre și migrează în bancuri mari pentru a alunga prădătorii. Sunt prădați de codul Atlantic și de macrou mai mare, precum și de rechini, păsări marine, balene, delfini și ton.",
        "image" : "C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/Macrou.jpg"
    },
    {
        "nume" : "Peste Spada",
        "descriere" : "Peștele-spadă este singura specie din familia Xiphiidae. Sunt pești mari de pradă care migrează odată cu schimbarea anotimpurilor. Sunt pești sportivi populari și au corpuri rotunde alungite. Ei prosperă în regiunile temperate și tropicale din Oceanul Indian, Pacific și Atlantic.",
        "image" : "C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/Peste-spada.jpg"
    },
    {
        "nume" : "Pastrav",
        "descriere" : "Păstrăvul curcubeu este o specie a familiei Salmonid și trăiește în Oceanul Pacific din America de Nord și Asia. Preferă apa rece și, de obicei, revine la apa dulce pentru a depune icre. Pot cântări până la 2,3 Kg, dar diferitele rase pot cântări până la 20 Kg.",
        "image" : "C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/Pastrav.jpg"
    },
    {
        "nume" : "Cod Atlantic",
        "descriere" : "Locuiește în habitate de la platforma continentală principală până la țărm, motiv pentru care este mai ușor de prins în tot felul de ape. Au de obicei o lungime de 61 cm până la 1,2 m și cântăresc până la 40 kg.",
        "image" : "C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/Cod-Atlantic.jpg"
    },
    {
        "nume" : "Ton",
        "descriere" : "Tonul este un pește de apă sărată care aparține familiei Scombridae. Au un total de 15 specii în care dimensiunile pot varia, inclusiv tonul roșu atlantic. Pot trăi în medie până la 50 de ani și pot menține o temperatură corporală mai mare decât apa din jurul lor.",
        "image" : "C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/Ton.jpg"
    }
];
var nofish=pesti.length;
var fish_positions=[];
var castig=0;

function show_fish(i,j){
    var overlay = document.getElementById('overlay');
    overlay.style.backgroundColor="rgb(72, 93, 209)";
    var popup= document.getElementsByClassName('popUp');
    popup[1].style.background="rgb(63, 106, 212)";
    popup[1].style.borderColor="rgb(100, 200, 212)";
        openPopUp(i);
        let vechi=fish_positions[i].positions[j][2];
        fish_positions[i].positions[j][2]=vechi+1;
        if(fish_positions[i].positions[j][2]==1){
            increment(i);
        }
        let x=document.getElementsByClassName("close-button");
         x[1].addEventListener("click",()=>{closePopUp()});
    
}

function add_fish(nrows,ncols){
    var color="rgb(8,9,300)"
    var color2="rgb(179, 224, 248)";
    var tbl=document.getElementById("acvariu");
    var cells=tbl.childNodes;

    for(let i=0;i<nrows;i++){
        for(let j=0;j<ncols;j++){     
        cells[i*ncols+j].addEventListener("click",()=>{ 
                activateCell(i*ncols+j,color);
            });
        
        }
    }

    var verificat=[];
    for(let i=0;i<nrows;i++){
        verificat.push(new Array(ncols,0));
    }
    for(let i=0;i<nofish;i++){
        var obj={};
        obj.type=i;
        obj.no= (Math.floor(Math.random()*10))%maxnooffish+1; //un nr de pesti de un tip de la 1 la 5
        castig+=obj.no;
        obj.positions=[];
        for(let j=0;j<obj.no;j++){
            let x=(Math.floor(Math.random()*100))%ncols;
            let y=(Math.floor(Math.random()*100))%nrows;
            if(!verificat[y][x]){
                verificat[y][x]=1;
                obj.positions.push([y,x,0]);
            }
            else{ j--;}
            
        }
        fish_positions.push(obj);
        console.log(fish_positions);
        console.log(obj.positions);
    }

    for(let i=0;i<nofish;i++){
        var obj=fish_positions[i];
        for(let j=0;j<obj.no;j++){
            let row=obj.positions[j][0];
            let col=obj.positions[j][1];
            cells[row*ncols+col].addEventListener("click",()=>{
                show_fish(i,j);
                activateCell(row*ncols+col,color2);
            })
        }
    }
    
    
}
//pentru pesti
function openPopUp(i){
    let but=document.getElementById("genericpopUp");
    but.classList.add('active');
    var overlay = document.getElementById('overlay');
    console.log(overlay);
    overlay.classList.add('active');
    let clasa=document.getElementsByClassName("generic");
    clasa[0].style.visibility='visible';

    let nume=pesti[i].nume;
    let text=pesti[i].descriere;
    let src=pesti[i].image;

    document.getElementById("par").innerHTML=text;
    document.getElementById("imgpeste").src=src;
    document.getElementById("titluu").innerHTML=nume;
}

function closePopUp(){
    let but=document.getElementById("genericpopUp");
    but.classList.remove('active');
    var overlay = document.getElementById('overlay');
    overlay.classList.remove('active');
    let clasa=document.getElementsByClassName("generic");
    clasa[0].style.visibility='hidden';
    overlay.style.backgroundColor="rgb(80, 63, 34)";
}

//pentru reguli
function openPopUp2(clas,text){
    let but=document.getElementById(text);
    but.classList.add('active');
    var overlay = document.getElementById('overlay');
    console.log(overlay);
    overlay.classList.add('active');
    let clasa=document.getElementsByClassName(clas);
    clasa[0].style.visibility='visible';
}

function closePopUp2(clas,text){
    let but=document.getElementById(text);
    but.classList.remove('active');
    var overlay = document.getElementById('overlay');
    overlay.classList.remove('active');
    let clasa=document.getElementsByClassName(clas);
    clasa[0].style.visibility='hidden';
    overlay.style.backgroundColor="rgb(80, 63, 34)";
}

function increment(i){
    //afisam ca am pescuit pestele respectiv
    var pescuiti= sessionStorage.getItem("pesti");
    pescuiti=JSON.parse(pescuiti);
    pescuiti[i]++;
    sessionStorage.setItem("pesti",JSON.stringify(pescuiti));
    var l=JSON.parse(localStorage.getItem("TotalPesti"));
    localStorage.setItem("TotalPesti",l+1);

    castig--;

    var text=document.getElementsByClassName("counter");
    text[i].textContent = pesti[i].nume+": "+pescuiti[i]+"/"+fish_positions[i].no;
    text[nofish].textContent ="In total ai pescuit: "+localStorage.getItem("TotalPesti")+" pesti";

    if(castig==0){
        setTimeout(()=>{winwin();}, 5000);
    }
}

function winwin(){
    let but=document.getElementById("genericpopUp");
    but.classList.add('active');
    var overlay = document.getElementById('overlay');
    console.log(overlay);
    overlay.classList.add('active');
    let clasa=document.getElementsByClassName("generic");
    clasa[0].style.visibility='visible';

    let nume="Felicitari!!";
    let text="Ai castigat!!"+"/n"+"Acum poti completa formularul de mai jos pentru a putea castiga un cupon de reducere 90% la unul dintre pestii nostri faimosi!";
    //let src="C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/pesti_img/winner.jpg";
    let aux=document.getElementById("popUpBody");
    let a=document.createElement("a")
    a.href="C:/Users/Paula/Desktop/anul1/sem2/tehnici_web/Proiect/piata.html/formular.html";
    aux.appendChild(a);


    document.getElementById("par").innerHTML=text+"/n";
    document.getElementById("titluu").innerHTML=nume;
}

window.onload= function(){
    resize_body();
    var nrows=20;
    var ncols=20;
    draw_water(nrows,ncols);
    add_fish(nrows,ncols);

    /*butoane wave si stop wave*/
    let b=document.getElementById("wave");
    b.addEventListener("click",()=>{wave(nrows)});

    let b2=document.getElementById("stopWave");
    b2.addEventListener("click",()=>{stopWave()});

    /*buton popup*/

    let popup=document.getElementById("popUp");
    popup.addEventListener("click",()=>{openPopUp2('popups','textpopUp')});
    
    let x=document.getElementsByClassName("close-button");
    x[0].addEventListener("click",()=>{closePopUp2('popups','textpopUp')});

    /*pescuim peste*/
    var pescuiti=[];
    for(let i=0;i<nofish;i++){
        pescuiti.push(0);
    }

    var text=document.getElementsByClassName("counter");
    for(let i=0;i<nofish;i++)
        text[i].textContent = pesti[i].nume+": "+pescuiti[i]+"/"+fish_positions[i].no;

    pescuiti=JSON.stringify(pescuiti);
    sessionStorage.setItem("pesti",pescuiti);
    var l=localStorage.getItem("TotalPesti");
    if(!l){
        localStorage.setItem("TotalPesti",JSON.stringify(0));
    }
    text[nofish].textContent ="In total ai pescuit: "+localStorage.getItem("TotalPesti")+" pesti";
    
    //stergere elemente 
    
    document.addEventListener("keydown",stergemElm);


    //altcv
    
    document.getElementById("undita").addEventListener("click",function (e){
        e.stopPropagation();
        e.target.style.backgroundColor="rgb(19, 19, 157)";
    })
    let count=document.getElementById("pesti");
    let li=count.childNodes;
    for(let i=0;i<li.length;i++){
        li[i].addEventListener("click",function(e){
            e.stopPropagation();
            e.target.style.backgroundColor="rgb(63, 106, 212)";
            
        })
    }
    
}

function stergemElm(event){
    
    var ul= document.getElementById("pesti");
    switch(event.keyCode){
        case 77://m-macrou
            let p=document.getElementById("0");
            p.remove();
            break;
        case 83://s-spada
            let p1=document.getElementById("1");
            ul.removeChild(p1);
            break;
        case 80:
            let p2=document.getElementById("2");
            ul.removeChild(p2);
            break;
        case 65://a-atlantic
            let p3=document.getElementById("3");
            ul.removeChild(p3);
            break;
        case 84://t-ton
            let p4=document.getElementById("4");
            ul.removeChild(p4);
            break;
    }

}
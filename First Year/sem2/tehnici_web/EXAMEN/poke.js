let black= "rgb(0,0,0)";
let red="rgb(255, 0, 0)";
let white="rgb(255,255,255)";

var nr= new Array();
for(let i=0;i<15;i++){
    nr.push(0);
}

window.onload = function(){
    var canvas= document.getElementById("canvas");
    if(canvas.getContext){
        var ctx=canvas.getContext("2d");
        draw1(ctx);
        draw2(ctx);
        draw3(ctx);
        draw4(ctx);
        draw5(ctx);
        draw6(ctx);
    }
    console.log(nr);
    nr=JSON.stringify(nr);
    sessionStorage.setItem("nr",nr);
    canvas.addEventListener("click",()=>{
        const promise = fetch("EXAMEN/poke.json");
           promise.then(response => response.json()).then(
              response => {pokemon(response)});
     });
     
}

function pokemon_afis(response,i){
    let div=document.getElementById("info");
    let ul=document.createElement("ul");
    
    let li=document.createElement("li");
    li.innerHTML="Level: "+response[i].level;
    ul.appendChild(li);
    let li2=document.createElement("li");
    li2.innerHTML="Ability: "+response[i].ability;
    ul.appendChild(li2);
    div.appendChild(ul);
}

function pokemon(response){
    console.log(response);
    let n=response.length;
   let i=(Math.floor(Math.random() * 100))%n;
   console.log(i);

   nr=JSON.parse(sessionStorage.getItem("nr"));
   nr[i]++;
   sessionStorage.setItem("nr",JSON.stringify(nr));

   let div=document.getElementById("info");
   while(div.firstChild){
        div.removeChild(div.firstChild);
   }
   let p=document.createElement("p");
   p.innerHTML=response[i].name+", I choose you!"+nr[i];
   console.log(p);
   let img=document.createElement("img");
   img.src=response[i].image;
   let ul=document.createElement("ul");
    
   let li=document.createElement("li");
   li.innerHTML="Level: "+response[i].level;
   ul.appendChild(li);
   let li2=document.createElement("li");
   li2.innerHTML="Ability: "+response[i].ability;
   ul.appendChild(li2);
   div.appendChild(ul);
   ul.style.visibility="hidden";
   div.appendChild(p);
   div.appendChild(img);
   div.addEventListener("mouseover",pokemon_afis(response,i));

   
}

function draw1(ctx){
    ctx.beginPath();
    let x = 100; // x coordinate
    let y = 100; // y coordinate
    let radius = 50; // arc radius   
    let startAngle = 0; // starting point on circle         
    let endAngle = Math.PI+Math.PI; // end point on circle
    let counterclockwise = 0; // clockwise or counterclockwis
    ctx.fillStyle=black;
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.fill();
    ctx.closePath();
    
}
function draw2(ctx){
    ctx.beginPath();
    let x = 100; // x coordinate
    let y = 100; // y coordinate
    let radius = 45; // arc radius   
    let startAngle = 0; // starting point on circle         
    let endAngle = Math.PI; // end point on circle
    let counterclockwise = 0; // clockwise or counterclockwis
    ctx.fillstyle=white;
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.fillStyle=white;
    console.log(ctx.fillstyle)
    ctx.fill();
}
function draw3(ctx){
    ctx.beginPath();
    let x = 100; // x coordinate
    let y = 100; // y coordinate
    let radius = 45; // arc radius   
    let startAngle = 0; // starting point on circle         
    let endAngle = Math.PI; // end point on circle
    let counterclockwise = 1; // clockwise or counterclockwis
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.fillStyle=red;
    console.log(ctx.fillstyle)
    ctx.fill();
}
function draw4(ctx){
    ctx.beginPath();
    let x = 100; // x coordinate
    let y = 100; // y coordinate
    let radius = 17.5; // arc radius   
    let startAngle = 0; // starting point on circle         
    let endAngle = 2*Math.PI; // end point on circle
    let counterclockwise = 1; // clockwise or counterclockwis
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.fillStyle=white;
    console.log(ctx.fillstyle)
    ctx.fill();

}
function draw5(ctx){
    ctx.beginPath();
    let x = 100; // x coordinate
    let y = 100; // y coordinate
    let radius = 17.5; // arc radius   
    let startAngle = 0; // starting point on circle         
    let endAngle = 2*Math.PI; // end point on circle
    let counterclockwise = 1; // clockwise or counterclockwis
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.stokeStyle=black;
    ctx.stroke();
}
function draw6(ctx){
    ctx.beginPath();
    ctx.moveTo(82,100);
    ctx.lineTo(50,100);
    ctx.moveTo(120,100);
    ctx.lineTo(150,100);
    ctx.stokeStyle=black;
    ctx.stroke();
}
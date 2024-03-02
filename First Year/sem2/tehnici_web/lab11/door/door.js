var framecol="rgb(200, 0, 0)";
var doorcol="rgb(200, 0, 0)";
var knobcol="rgb(255,255,255)";
var choice="rgb(240,230,100)";

window.onload = function() {
   draw(framecol,doorcol,knobcol);
   //closing2();
   var door= document.getElementById("canvdoor");
   //var b=door.getContext("2d");
   console.log(door);
   door.addEventListener("click",onclick);
}   
function onclick(){
   colorBlack();
   setTimeout(closing,1000);
}
function closing(){
   closing1();
   setTimeout(closing2,300);
   setTimeout(closing3,600);
}
function closing1(){
   const canvas = document.getElementById("canvdoor");
   if (canvas.getContext) {
      const ctx = canvas.getContext("2d");
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      //cadrul usii
      ctx.fillStyle = framecol;
      ctx.fillRect(30, 50, 70, 100);
      ctx.clearRect(35,55,60,100);

      //usa
      ctx.beginPath();
         ctx.moveTo(37,57);
         ctx.lineTo(90,50);
         ctx.lineTo(90,150);
         ctx.lineTo(37,150);
         ctx.closePath();
         ctx.fillStyle= doorcol;
         ctx.fill();
      
      //clanta
      ctx.beginPath();
      const x = 80; // x coordinate
      const y = 110; // y coordinate
      const radius = 2; // arc radius   
      const startAngle = 0; // starting point on circle         
      const endAngle = 2*Math.PI; // end point on circle
      const counterclockwise = 0; // clockwise or counterclockwis
      ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
      ctx.fillStyle=knobcol;
      ctx.fill();
   }
}
function closing2(){
   const canvas = document.getElementById("canvdoor");
   if (canvas.getContext) {
      const ctx = canvas.getContext("2d");
      ctx.clearRect(0, 0, canvas.width, canvas.height);
      //cadrul usii
      ctx.fillStyle = framecol;
      ctx.fillRect(30, 50, 70, 100);
      ctx.clearRect(35,55,60,100);

      //usa
      ctx.beginPath();
         ctx.moveTo(37,57);
         ctx.lineTo(94,60);
         ctx.lineTo(94,148);
         ctx.lineTo(37,150);
         ctx.closePath();
         ctx.fillStyle= doorcol;
         ctx.fill();
      
      //clanta
      ctx.beginPath();
      const x = 84; // x coordinate
      const y = 110; // y coordinate
      const radius = 2; // arc radius   
      const startAngle = 0; // starting point on circle         
      const endAngle = 2*Math.PI; // end point on circle
      const counterclockwise = 0; // clockwise or counterclockwis
      ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
      ctx.fillStyle=knobcol;
      ctx.fill();
   }
}
function closing3(){
   const canvas = document.getElementById("canvdoor");
      if (canvas.getContext) {
         const ctx = canvas.getContext("2d");
         ctx.clearRect(0, 0, canvas.width, canvas.height);
         //cadrul usii
         ctx.fillStyle = framecol;
         ctx.fillRect(30, 50, 70, 100);
         ctx.clearRect(35,55,60,100);

         //usa
         ctx.fillStyle= doorcol;
         ctx.fillRect(37,57,55,91);
         
         //clanta
         ctx.beginPath();
         const x = 86; // x coordinate
         const y = 110; // y coordinate
         const radius = 2; // arc radius   
         const startAngle = 0; // starting point on circle         
         const endAngle = 2*Math.PI; // end point on circle
         const counterclockwise = 0; // clockwise or counterclockwis
         ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
         ctx.fillStyle=knobcol;
         ctx.fill();
      }
}

function colorBlack() {
   // colorăm ușa în negru   
   console.log("clicked");
   draw(framecol,choice,knobcol);
    
}

function draw(framecol, doorcol, knobcol) {
   // desenăm ușa roșie
   const canvas = document.getElementById("canvdoor");
      if (canvas.getContext) {
         const ctx = canvas.getContext("2d");
         //cadrul usii
         ctx.fillStyle = framecol;
         ctx.fillRect(30, 50, 70, 100);
         ctx.clearRect(35,55,60,100);

         //usa
         ctx.beginPath();
         ctx.moveTo(37,57);
         ctx.lineTo(80,40);
         ctx.lineTo(80,160);
         ctx.lineTo(37,150);
         ctx.closePath();
         ctx.fillStyle= doorcol;
         ctx.fill();
         
         //clanta
         ctx.beginPath();
         const x = 74; // x coordinate
         const y = 110; // y coordinate
         const radius = 2; // arc radius   
         const startAngle = 0; // starting point on circle         
         const endAngle = 2*Math.PI; // end point on circle
         const counterclockwise = 0; // clockwise or counterclockwis
         ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
         ctx.fillStyle=knobcol;
         ctx.fill();
      }
}   
      

      
//http://www.java2s.com/Tutorials/HTML_CSS/HTML5_Canvas/0630__HTML5_Canvas_Event.htm
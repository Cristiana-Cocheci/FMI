window.onload = function() {
  var starttime = Date.now();
  draw();
           
}       
function corp(){
  var canvas= document.getElementById("canvas");
  ctx=canvas.getContext("2d");
  
  ctx.beginPath();
  const x = 70; // x coordinate
  const y = 100; // y coordinate
  const radius = 30; // arc radius   
  const startAngle = 0; // starting point on circle         
  const endAngle = 2*Math.PI; // end point on circle
  const counterclockwise = 0; // clockwise or counterclockwis
  ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
  ctx.fillStyle="rgb(240,230,100)";
  ctx.fill();
}
function gura(){
  var canvas= document.getElementById("canvas");
  ctx=canvas.getContext("2d");
  ctx.beginPath();
  const x = 70; // x coordinate
  const y = 100; // y coordinate
  const radius = 31; // arc radius   
  const startAngle = Math.PI+3*Math.PI/4; // starting point on circle         
  const endAngle = -(Math.PI+3*Math.PI/4); // end point on circle
  const counterclockwise = 0; // clockwise or counterclockwis
  ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
  ctx.lineTo(70,100);
  ctx.fillStyle="rgb(0,0,0)";
  ctx.fill();
}

function ochi(){
  var canvas= document.getElementById("canvas");
  ctx=canvas.getContext("2d");
  ctx.beginPath();
  const x = 70; // x coordinate
  const y = 82; // y coordinate
  const radius = 2; // arc radius   
  const startAngle = 0; // starting point on circle         
  const endAngle = 2*Math.PI; // end point on circle
  const counterclockwise = 0; // clockwise or counterclockwis
  ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
  ctx.fillStyle="rgb(0,0,0)";
  ctx.fill();
}

function draw() {
  const nowtime = Date.now();
  // folosiți diferența nowtime - starttime pentru animație
  //corp
  corp();
  //gura
  gura();
  ochi();
 


} 
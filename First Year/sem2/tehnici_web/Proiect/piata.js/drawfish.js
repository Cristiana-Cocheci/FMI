const lightblue="rgb(139, 199, 214)";
const darkblue= "rgb(54, 96, 186)";
const lightyellow="rgb(233, 235, 115)";
const darkerblue="rgb(24, 35, 128)";
const black= "rgb(0,0,0)";
const bluish="rgb(89, 103, 222)";

window.onload = function(){
    draw_spearfish();
    dotted_spearfish();
    //draw();
}
function draw(){
    let titlu=document.getElementById("titlu");
    let style=getComputedStyle(titlu);
    console.log(style);
    if(style.color==black){
        titlu.color=darkerblue;
    }
    /*var canvas= document.getElementById("canvas3");
        var ctx=canvas.getContext("2d");
        ctx.lineWidth=5;
        var canvasPressed = false;
        canvas.addEventListener('mousedown', function (evt) {
            console.log('event mousedown', evt);
            canvasPressed = true;
            ctx.beginPath();
            ctx.moveTo(evt.clientX, evt.clientY);
          });
          
          canvas.addEventListener('mouseup', function (evt) {
            console.log('event mouseup', evt);
            ctx.closePath();
            canvasPressed = false;
          });
          
          canvas.addEventListener('mousemove', function (evt) {
            console.log('event mousemove', evt);
            if (canvasPressed) {
              ctx.lineTo(evt.clientX, evt.clientY);
              ctx.moveTo(evt.clientX, evt.clientY);
              ctx.strokeStyle=lightyellow;
              ctx.stroke();
            }
          });
    */
}
function dotted_spearfish(){
    var canvas= document.getElementById("canvas2");
    if(canvas.getContext){
        var ctx=canvas.getContext("2d");
        nas2(ctx,2);
        coada(ctx,2);
        //corp
        corp(ctx,2);
        //aripioara1
        aripioara(ctx,2);
        //nas
        nas(ctx,2);
        //cap
        cap(ctx,2);
        //ochi
        ochi(ctx,2);
        
    }
}

function draw_spearfish(){
    var canvas= document.getElementById("canvas1");
    if(canvas.getContext){
        var ctx=canvas.getContext("2d");
        
        coada(ctx,1);
        
        //corp
        //nas2(ctx,1);
        
        nas2(ctx,1);
        corp(ctx,1);
        //aripioara1
        aripioara(ctx,1);
        //nas        
        
        nas(ctx,1);
        //cap
        cap(ctx,1);
        //ochi
        ochi(ctx,1);

    }
}
function nas2(ctx,i){
    ctx.beginPath();
    ctx.moveTo(240,110);
    ctx.lineTo(350,147);

    if(i==2){
        ctx.strokeStyle=bluish;
        ctx.stroke();
    }
    else{
        ctx.lineTo(240,140);
        ctx.closePath();
        ctx.fillStyle=bluish;
        ctx.fill();
        
    }
}
function aripioara(ctx,i){
    ctx.beginPath();
    ctx.moveTo(80,144);
    ctx.lineTo(235,60);
    ctx.lineTo(235,110);
    ctx.closePath();
    if(i==1){
        ctx.fillStyle=darkerblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkerblue;
        ctx.stroke();
    }
    

}

function coada(ctx,i){
    ctx.beginPath();
    ctx.moveTo(55,150);
    ctx.lineTo(18,120);
    ctx.lineTo(84,145);
    ctx.closePath();
    if(i==1){
        ctx.fillStyle=darkerblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkerblue;
        ctx.stroke();
    }

    ctx.beginPath();
    ctx.moveTo(55,150);
    ctx.lineTo(18,180);
    ctx.lineTo(84,155);
    ctx.closePath();
    if(i==1){
        ctx.fillStyle=darkerblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkerblue;
        ctx.stroke();
    }

}
function ochi(ctx,i){
    ctx.beginPath();
    ctx.moveTo(255,140);//start point
    //control 1, control2, end point
    ctx.bezierCurveTo(260,130,270,130,270,145);
    ctx.bezierCurveTo(260,135,270,135,255,140);

    if(i==1){
        ctx.fillStyle=darkerblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkerblue;
        ctx.stroke();
    }
}

function nas(ctx,i){
    ctx.beginPath();
    ctx.moveTo(276,140);
    ctx.lineTo(400,150);
    ctx.lineTo(276,160);
    
    ctx.closePath();
    if(i==1){
        ctx.fillStyle=darkerblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkerblue;
        ctx.stroke();
    }
   

}
function cap(ctx,i){
    ctx.beginPath();
    ctx.moveTo(240,190);//start point
    //control 1, control2, end point
    ctx.bezierCurveTo(290,180,290,120,240,110);
    
    if(i==1){
        ctx.fillStyle=darkblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkblue;
        ctx.stroke();
    }
    //.2
    ctx.beginPath();
    ctx.moveTo(240,190);//start point
    //control 1, control2, end point
    ctx.bezierCurveTo(180,180,180,120,240,110);
    
    if(i==1){
        ctx.fillStyle=darkblue;
        ctx.fill();
    }
    
}
function corp(ctx,i){
    ctx.beginPath();
    const x = 282; // x coordinate
    const y = 150; // y coordinate
    const radius = 59; // arc radius   
    const startAngle = Math.PI-Math.PI/4; // starting point on circle         
    const endAngle = Math.PI+Math.PI/4; // end point on circle
    const counterclockwise = 0; // clockwise or counterclockwis
    ctx.arc(x, y, radius, startAngle, endAngle, counterclockwise);
    ctx.lineTo(53,150);
    ctx.closePath();
    if(i==1){
        ctx.fillStyle=darkblue;
        ctx.fill();
    }
    else{
        ctx.strokeStyle=darkblue;
        ctx.stroke();
    }
    
   
}

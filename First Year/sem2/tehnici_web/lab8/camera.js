var cnt=0;

function timer_5s(i){
    if(i<0){
        setTimeout(()=>{document.getElementById("timer").style.visibility="hidden";}, 1000);
        return;
    }
    document.getElementById("timer").innerHTML=i;
    setTimeout(()=>{ timer_5s(i-1);},1000);
}

function eveniment(event){

    var vizor = document.getElementById("vizor");
    var aux=vizor.children;
    var imagine=aux[0];
    var style= window.getComputedStyle(imagine);
    switch (event.keyCode) {
        case 38: //up
            if(parseInt(style.marginTop)<=-30)
                imagine.style.marginTop = String(parseInt(style.marginTop)+30)+'px';
            break;
        case 37: //left
            if(parseInt(style.marginLeft)<=-20)
            imagine.style.marginLeft = String(parseInt(style.marginLeft)+30)+'px';
            break;
        case 40: //down
            if(parseInt(style.marginTop)>=-1700)
            imagine.style.marginTop = String(parseInt(style.marginTop)-30)+'px';
            break;
        case 39: //right
            if(parseInt(style.marginLeft)>=-1550)
            imagine.style.marginLeft = String(parseInt(style.marginLeft)-30)+'px';
            break;
        case 187: //plus
            var prev=style.transform;
            console.log(prev);
            console.log(prev.substring(7,10));
            var value= parseFloat(prev.substring(7,10)) + 0.2;          
            value='scale('+value.toString()+')';
            console.log(value);
            imagine.style.transform= value;
            break;
        case 189: //minus
            var prev=style.transform;
            console.log(prev);
            console.log(prev.substring(7,10));
            var value= parseFloat(prev.substring(7,10)) - 0.2;          
            value='scale('+value.toString()+')';
            console.log(value);
            imagine.style.transform= value;
        break;
        case 83: //s
            document.getElementById("container").classList.add("animation");
            let container= (document.getElementById("container")).cloneNode(true);
            container.classList.remove("animation");
            cnt++;
            container.id="container"+cnt;
            container.children[0].id="vizor"+cnt;
            container.style.margin="5px";
            let gal=document.getElementById("galerie");
            gal.appendChild(container);
            setTimeout(()=>{
                document.getElementById("container").classList.remove("animation");
            },1100);
            break;
            
        case 84: //t
            timer_5s(5);
            setTimeout(()=>{
                document.getElementById("container").classList.add("animation");
                let container= (document.getElementById("container")).cloneNode(true);
                container.classList.remove("animation");
                cnt++;
                container.id="container"+cnt;
                container.children[0].id="vizor"+cnt;
                container.style.margin="5px";
                let gal=document.getElementById("galerie");
                gal.appendChild(container);
                setTimeout(()=>{
                    document.getElementById("container").classList.remove("animation");
                },1000);
            },5000);
            document.getElementById("timer").style.visibility="visible";
            break;
        case 66:
            var i=setInterval(()=>{
                document.getElementById("container").classList.add("animation");
                let container= (document.getElementById("container")).cloneNode(true);
                container.classList.remove("animation");
                cnt++;
                container.id="container"+cnt;
                container.children[0].id="vizor"+cnt;
                container.style.margin="5px";
                let gal=document.getElementById("galerie");
                gal.appendChild(container);
                setTimeout(()=>{
                    document.getElementById("container").classList.remove("animation");
                },1100);
            },500);
            setTimeout(()=>{clearInterval(i)},2000);
            break;
            
        default:
        return; 
    }
}

window.onload = function(){
    document.getElementById("timer").style.visibility="hidden";
    document.addEventListener("keyup" , eveniment);
}
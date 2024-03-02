function buton(){
    console.log("submit");
  }
  

window.onload=function()
{
    let b=document.getElementById("sub");
    b.addEventListener("click",buton());

    let data=document.getElementById("dataExp");
    const d=new Date(2023,11,12,13,33,30);
    data.innerHTML="Data de expirare a formularului:\n"+d;

    let dd=document.getElementById("dataAzi");
    const ddd=new Date();
    dd.innerHTML="Data de completare a formularului:\n"+ddd.getDate()+"/"+(ddd.getMonth()+1)+"/"+ddd.getFullYear();
    
    let p=document.getElementById("multumim");
    let aux= new String("multumim !")
    aux= aux.toUpperCase();
    p.innerHTML=aux;


}
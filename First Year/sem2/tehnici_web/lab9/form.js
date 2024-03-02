function colorchange(){
  var culoare= document.getElementById("culoare");
  culoare.addEventListener("input", ()=>{
    document.getElementsByTagName("body")[0].style.backgroundColor=culoare.value;
    localStorage.setItem("culoare", culoare.value); 
  });
  
}


function buton(){
  let win=document.getElementById("popUp");
  console.log(win);
  win.style.visibility="visible";
  let b=document.getElementById("close");
    b.addEventListener("click",butonclose());
}

function butonclose(){
  let win=document.getElementById("popUp");
  console.log(win);
  win.style.visibility="hidden";
}

window.onload = function(){
  /*for (let i = 0; i < localStorage.length; i++) {
    console.log(localStorage.key(i));
  }*/
  document.getElementsByTagName("body")[0].style.backgroundColor=localStorage.getItem("culoare");
  document.getElementById("culoare").value=localStorage.getItem("culoare");
    colorchange();

    let b=document.getElementById("sub");
    
    b.addEventListener("click",buton());
    
  }
  

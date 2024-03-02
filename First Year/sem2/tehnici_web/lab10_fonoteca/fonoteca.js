/*window.onload = function() {
   makeRequest();
}
function makeRequest() {
   var data_request = new XMLHttpRequest();
   if (!data_request) {
      alert('request impossible - ce trist ;(');
      return false;
   }
   data_request.onreadystatechange = manageData;
   data_request.open('GET', '/lab10_fonoteca/albums.json');
   data_request.send();   
 
   function manageData() {
   if (data_request.readyState == 4) {
      if (data_request.status == 200) {
        var json_albums = data_request.responseText;
        var data = JSON.parse(json_albums);
        var gal = document.getElementById("gallery");
        gal.style.width = "30vw";
        gal.style.backgroundColor = "blue";
        gal.style.padding = "2vw"; 
        gal.style.gridTemplateColumns = "repeat(3, 1fr)";
          for (var i = 0; i < data.length; i++){
            let new_image = document.createElement('img');
            new_image.src = "images/" + data[i].image;
            new_image.style.width = "10vw";
            new_image.classList.add("album" + i);

            new_image.addEventListener("click", function(event){
               var info_box = document.getElementById("info");
               let colors = ["rgb(255, 0, 0)", "rgb(255, 154, 0)", "rgb(240, 240, 0)", "rgb(79, 220, 74)", "rgb(63, 218, 216)", "rgb(47, 201, 226)", "rgb(28, 127, 238)", "rgb(95, 21, 242)", "rgb(186, 12, 248)", "rgb(251, 7, 217)"];
               let rando = parseInt(Math.random() * 10);   
               const imag_class = event.target.className.replace(/[^0-9]/g, ''); // 👉️ '123'
               let index = parseInt(imag_class);               

               info_box.style.width = "40vw";
               info_box.style.height = "20em";
               info_box.style.marginLeft = "20vw";
               info_box.style.marginTop = "10vh";
               info_box.style.backgroundColor = colors[rando];
               info_box.style.transition = "background-color 0.5s";

               const promise = fetch("/lab10_fonoteca/albums/" + index + ".json");
               promise.then(response => response.json()).then(
                  response => display_data(response));
               });

            gal.appendChild(new_image);
        }
      } 
      else 
        alert('request failed - ce trist ;(');
      }
   }
}
function display_data(data_object){
   console.log(data_object);
   var info_box = document.getElementById("info");
   while (info_box.firstChild) {
      info_box.removeChild(info_box.lastChild);
   }
   var list = document.createElement("ul");
   
   let title = document.createElement("li");
   title.innerHTML = data_object.name;
   let artist = document.createElement("li");
   artist.innerHTML = data_object.artist;
   let year = document.createElement("li");
   year.innerHTML = data_object.year;
   let label = document.createElement("li");
   label.innerHTML = data_object.label;
   let format = document.createElement("li");
   format.innerHTML = data_object.format;

   let genres = document.createElement("li");
   genres.innerHTML = data_object.genres[0];
   for(let k = 1; k < data_object.genres.length; k++){
      genres.innerHTML += " & " + data_object.genres[k];
   }

   list.appendChild(title);
   list.appendChild(artist);
   list.appendChild(year);
   list.appendChild(label);
   list.appendChild(format);
   list.appendChild(genres);

   info_box.appendChild(list);
}*/

var httpRequest;
var array =[];





function makeRequest(){
   httpRequest = new XMLHttpRequest();
   if(!httpRequest){
      alert ('sorry, what?');
      return false;
   }
   httpRequest.onreadystatechange = trygetAlbums;
   httpRequest.open('GET',"http://localhost:8000/lab10_fonoteca/albums.json");
   httpRequest.send();
}

function trygetAlbums(){
   if(httpRequest.readyState == 4){
      if(httpRequest.status == 200){
         getAlbums();
      }
   }
}

function getAlbums(){
   var jsonFile = httpRequest.responseText;
   var data = JSON.parse(jsonFile);
   for (let i=0; i<data.length; i++){
      let obj=[];
      obj.push(data[i].name); //0=name
      obj.push(data[i].artist); //1=artist
      obj.push(data[i].image); //2=image
      //console.log(obj);
      array.push(obj);
   }

   buildpage();
}

function buildpage(){
   var gal=document.getElementById("gallery");
   var info= document.getElementById("info");

   for(var i=0;i<array.length; i++){
         //date- goale, momentan
         let div2=document.createElement("div");
         div2.id="infoB"+i;
         div2.style.visibilty="hidden";
         div2.style.background="rgb(255,255,255)";
         div2.innerHTML="kfsdjavjalebcvba";
         info.appendChild(div2);
         div2.addEventListener("click",()=>{
            div2.style.visibility="hidden";
         })

      //poze
      let div= document.createElement("div");
      div.id="album"+i;
      div.classList.add("albumPic");
      let img = document.createElement("img");
      img.src="images/"+array[i][2];
      div.addEventListener("click",()=>{
         const promise = fetch("http://localhost:8000/lab10_fonoteca/albums/"+parseInt(div.id.substring(5))+".json");
            promise.then(response => response.json()).then(
               response => {display_data(response,parseInt(div.id.substring(5)))});
      });

      div.appendChild(img);
      let p = document.createElement("p");
      p.innerHTML=array[i][0];
      div.appendChild(p);
      gal.appendChild(div);
   }
   

}

function display_data(response,i){
   console.log(response);
   console.log(i);
   let div=document.getElementById("infoB"+i);
   div.style.color="rgb(0,0,0)";
   console.log(div);
   div.style.visibility="visible";
   div.innerHTML=response.name+"\n"+response.artist+"\n";
   
}


window.onload= function(){
   makeRequest();
   console.log(array);
}





text='<cinemateca><film>'+
            '<titlu lang="en">Schindler_s List</titlu>'+
            '<gen>Biography, Drama, History</gen>'+
            '<regizor>Steven Spielberg</regizor>'+
            '<an>1993</an>'+
            '<scenarist>Thomas Keneally, Steven Zailian</scenarist>'+
            '<producatori>Branko Lustig, Gerald R. Molen</producatori>'+
            '<actori>Liam Neeson</actori>'+
            '<scor>9.0/10</scor>'+
        '</film>'+
        '<film>'+
            '<titlu lang="en">The Hobbit: An Unexpected Journey</titlu>'+
            '<gen>Advnture, Fantasy</gen>'+
            '<regizor>Peter Jackson</regizor>'+
            '<an>2012</an>'+
            '<scenarist>Fran Walsh, Philippa Boyens, Peter Jackson</scenarist>'+
            '<producatori>Carolynne Cunningham, Peter Jackson, Fran Walsh, Zane Weiner</producatori>'+
            '<actori>Martin Freeman, Ian McKellen</actori>'+
            '<scor>7.8/10</scor>'+
        '</film></cinemateca>';

    function afisare(){
var parser = new DOMParser();
var cinemateca = parser.parseFromString(text, "text/xml");
var filme=cinemateca.getElementsByTagName('film');
for(var i=0;i<filme.length;i++){
    var atribute=filme[i].childNodes;
    for(var j=0;j<atribute.length;j++){
        var titlu_ = atribute[j].nodeName;
	    var titlu = atribute[j].innerHTML;
        console.log(titlu_ + ': ' + titlu);
    }
	console.log('----');
}

var list=document.getElementById("lista");
for(var i=0;i<filme.length;i++){
    const ul=document.createElement("ul");
    ul.innerHTML= "film "+(i+1);
    var atribute=filme[i].childNodes;
    for(var j=0;j<atribute.length;j++){
        var li=document.createElement("li");
        var titlu_ = atribute[j].nodeName;
	    var titlu = atribute[j].innerHTML;
        li.innerHTML = titlu_ + ': ' + titlu;
        ul.appendChild(li);        
    }
    list.appendChild(ul);
    }
    }
window.onload= function(){
    afisare();
}
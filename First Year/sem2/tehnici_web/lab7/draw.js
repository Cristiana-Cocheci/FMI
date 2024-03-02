function drawTable(nrows, ncols) {
    /* 
       1. Generați un tabel cu 'nrows' rânduri și 'ncols' coloane 
       și adăugați-l în div-ul cu id-ul 'container'. 
    */
       tbl=document.getElementById("container");
       for (let i = 0; i < nrows; i++) {
         // creates a table row
         const row = document.createElement("tr");
     
         for (let j = 0; j < ncols; j++) {
           const cell = document.createElement("td");
           row.appendChild(cell);
         }
         tbl.appendChild(row);
      }
      var rows=document.querySelectorAll("tr");
      for(let i=0;i<rows.length;i++){
         var cols=rows[i].childNodes;
         for(let j=0;j<cols.length;j++){            
            //cols[j].addEventListener("click",()=> drawPixel(i,j,c));
            let color="#000000";
            var event=document.getElementById("color-picker");
            event.addEventListener("input",()=>{color=event.value});
            cols[j].addEventListener("click",()=>{drawPixel(i,j,color)});
         
         }
       }
       
   }
   function f(){}
    
    function colorCol(column, color) {
    /*
       2. Colorați coloana 'column' din tabla de desenat cu culoarea 'color'.
    */
       const rows=document.querySelectorAll("tr");
       for(let i=0;i<rows.length;i++){
         const cols=rows[i].childNodes;
         cols[column].style.background=color;
       }
    }
    
    function colorRow(row, color) {
    /*
       2. Colorați rândul 'row' din tabla de desenat cu culoarea 'color'.
    */
       const rows=document.querySelectorAll("tr");
       const row_bun=rows[row].childNodes;
       for(let i=0;i<row_bun.length;i++){
         row_bun[i].style.background=color;
       }
    }
    
    function rainbow(target) {
       let colors = ["rgb(255, 0, 0)", "rgb(255, 154, 0)", "rgb(240, 240, 0)", "rgb(79, 220, 74)", "rgb(63, 218, 216)", "rgb(47, 201, 226)", "rgb(28, 127, 238)", "rgb(95, 21, 242)", "rgb(186, 12, 248)", "rgb(251, 7, 217)"];
    /*
       3. Desenați un curcubeu pe verticală sau orizontală conform argumentului 'target' folosind culorile din 'colors' și funcțiile 'colorCol' și 'colorRow'.     
    */
      const rows=document.querySelectorAll("tr");
      var nrows=rows.length;
      var c=rows[0].childNodes;
      var ncols=c.length;
      if(target=="row"){
         var batch=nrows/10;
         var color=0;
         for(let i=0;i<nrows;i++){
            colorRow(i,colors[color]);
            if((i+1)%batch==0 && (i!=0|| batch==1)){
               color++;
            }
         }
      }
      else if(target=="col"){
         var batch=ncols/10;
         var color=0;
         for(let i=0;i<ncols;i++){
            colorCol(i,colors[color]);
            if((i+1)%batch==0 && (i!=0|| batch==1)){
               color++;
            }
         }
      }
    }
    
    function getNthChild(element, n) {
    /*
       4. Întoarceți al n-lea element copil al unui element dat ca argument.
    */
      var children=element.childNodes;
      return children[n];
    };
    
    function drawPixel(row, col, color) {	
    /*
       5. Colorați celula de la linia 'row' și coloana 'col' cu culoarea `color'.
    */
      var rows=document.querySelectorAll("tr");
      var cell=getNthChild(rows[row],col);
      cell.style.background=color;
    }
    
    function drawLine(r1, c1, r2, c2, color) {
    /*
       6. Desenați o linie (orizontală sau verticală) de la celula aflată 
       pe linia 'r1', coloana 'c1' la celula de pe linia 'r2', coloana 'c2'
       folosind culoarea 'color'. 
       Hint: verificați mai întâi că punctele (r1, c1) și (r2, c2) definesc
       într-adevăr o linie paralelă cu una dintre axe.
    */
      if(r1==r2){
         if(c1>c2){
            var aux=c1; c1=c2; c2=aux;
         }
         for(let i=c1; i<=c2;i++){
            drawPixel(r1,i,color);
         }
      }
      else if(c1==c2){
         if(r1>r2){
            var aux=r1; r1=r2; r2=aux;
         }
         for(let i=r1;i<=r2;i++){
            drawPixel(i,c1,color);
         }
      }
      else{
         alert("nu e linie dreapta");
      }
    }
    
    function drawRect(r1, c1, r2, c2, color) {
    /*
       7. Desenați, folosind culoarea 'color', un dreptunghi cu colțul din 
       stânga sus în celula de pe linia 'r1', coloana 'c1', și cu 
       colțul din dreapta jos în celula de pe linia 'r2', coloana 'c2'.
    */
      r1--;r2--;c1--;c2--;
      for(let r=r1; r<=r2;r++){
         drawLine(r,c1,r,c2,color);
      }
    }
    
    function drawPixelExt(row, col, color) {
    /*
       8. Colorați celula de la linia 'row' și coloana 'col' cu culoarea 'color'.
       Dacă celula nu există, extindeți tabla de desenat în mod corespunzător.
    */
       var rows=document.querySelectorAll("tr");
       var nrows=rows.length;
       var c=rows[0].childNodes;
       var ncols=c.length;
       row--;col--;
       if(row<nrows && col <ncols){
         drawPixel(row,col,color);
       }
       if(row>=nrows){
         tbl=document.getElementById("container");
         for (let i = nrows; i <= row; i++) {
            // creates a table row
            const row = document.createElement("tr");
            for (let j = 0; j < ncols; j++) {
               const cell = document.createElement("td");
               row.appendChild(cell);
            }
            tbl.appendChild(row);
         }
       }
       rows=document.querySelectorAll("tr");
       nrows=rows.length;
       c=rows[0].childNodes;
       ncols=c.length;
       if(col>=ncols){
         for(let j=0;j<nrows;j++){
            for(let i=ncols;i<=col;i++){
               const cell = document.createElement("td");
               rows[j].appendChild(cell);
            }
         }
         
       }
       if(c[0].style.background==c[ncols-1].style.background)
       {
         rainbow("row");
       }
       else{
         rainbow("col");
       }
       drawPixel(row,col,color);
    }
    
    function colorMixer(colorA, colorB, amount){
       let cA = colorA * (1 - amount);
       let cB = colorB * (amount);
       return parseInt(cA + cB);
    }
    
    function drawPixelAmount(row, col, color, amount) {
       /* 
       9. Colorați celula la linia 'row' și coloana 'col' cu culoarea 'color'
       în funcție de ponderea 'amount' primită ca argument (valoare între 0 și 1). 
       Dacă 'amount' are valoarea:
       1, atunci celula va fi colorată cu 'color'
       0, atunci celula își va păstra culoarea inițială
       pentru orice altă valoare, culoarea inițială și cea dată de argumentul 
       'color' vor fi amestecate. De exemplu, dacă ponderea este 0.5, atunci 
       culoarea inițială și cea nouă vor fi amestecate în proporții egale (50%). 
       */
      var rows= document.querySelectorAll("tr");
      var coll=rows[row].childNodes;
      var cell=coll[col];
      //culoare initiala
      var init_color= window.getComputedStyle(cell).backgroundColor;
      var values1= init_color.split(",");
      var x_init,y_init,z_init;
      x_init=parseFloat(values1[0].split("(")[1]);
      y_init=parseFloat(values1[1]);
      z_init=parseFloat(values1[2].split(")")[0]);
      //culoare data
      var values2= color.split(",");
      var x,y,z;
      x=parseFloat(values2[0].split("(")[1]);
      y=parseFloat(values2[1]);
      z=parseFloat(values2[2].split(")")[0]);
      //new color
      var x_nou, y_nou, z_nou;
      x_nou=parseInt(colorMixer(x_init,x,amount));
      y_nou=parseInt(colorMixer(y_init,y,amount));
      z_nou=parseInt(colorMixer(z_init,z,amount));
      var new_color="rgb("+x_nou+","+y_nou+","+z_nou+")";
      drawPixel(row,col,new_color);
       /*   
       Hint 1: folosiți funcția colorMixer de mai sus.
    
       Hint 2: pentru un argument 'color' de forma 'rgb(x,y,z)' puteți folosi
       let newColorArray = color.match(/\d+/g); 
       pentru a obține un Array cu trei elemente, corespunzătoare valorilor
       asociate celor trei culori - newColorArray = [x, y, z]
       
       Hint 3: pentru a afla culoarea de fundal a unui element puteți folosi
       metoda getComputedStyle(element). Accesând proprietatea backgroundColor 
       a obiectului întors, veți obține un string de forma 'rgb(x,y,z)'.
       */
    }
    
    function delRow(row) {
    /*
       10. Ștergeți linia cu numărul 'row' din tabla de desenat.
    */
      var rows=document.querySelectorAll("tr");
      rows[row].remove();

    }
    
    function delCol(col) {
    /*
       10. Ștergeți coloana cu numărul 'col' din tabla de desenat.
    */
       var rows=document.querySelectorAll("tr");
       var c=rows[0].childNodes;
       for(j=0;j<rows.length;j++){
         for(let i=0;i<c.length;i++){
            var cells=rows[j].childNodes;
            if(i==col)
               cells[col].remove();
         }
       }
       
    }
    
    function shiftRow(row, pos) {
    /*
       11. Aplicați o permutare circulară la dreapta cu 'pos' poziții a
       elementelor de pe linia cu numărul 'row' din tabla de desenat. 
    */
      var rows=document.querySelectorAll("tr");
      var r=rows[row].childNodes;
      var new_r=new Array;
      var ncols=r.length;
      for(let i=0;i<ncols;i++){
         var cell=r[(i+pos)%(ncols)];
         new_r.push(window.getComputedStyle(cell).backgroundColor);
      }
      for(let i=0;i<ncols;i++){
         drawPixel(row,i,new_r[i]);
      }
    }
    
    function jumble() {
    /*
       12. Folosiți funcția 'shiftRow' pentru a aplica o permutare circulară
       cu un număr aleator de poziții fiecărei linii din tabla de desenat.
    */
       var rows=document.querySelectorAll("tr");
       var r=rows[0].childNodes;
       var ncols=r.length;
       for(let i=0;i<rows.length;i++){
         var pos=parseInt(Math.random()*100)%ncols;
         shiftRow(i,pos);
       }
    }
    
    function transpose() {
    /*
       13. Transformați tabla de desenat în transpusa ei.
    */

    }
    
    function flip(element) {
    /*
       14. Inversați ordinea copiilor obiectului DOM 'element' primit ca argument.
    */
    }
    
    function mirror() {
    /*
       15. Oglindiți pe orizontală tabla de desenat: luați jumătatea stângă a tablei, 
       aplicați-i o transformare flip și copiați-o în partea dreaptă a tablei.
    */
    }
    
    function smear(row, col, amount) {
    /*
       16. Întindeți culoarea unei celule de pe linia 'row' și coloana 'col' în celulele
       învecinate la dreapta, conform ponderii date de 'amount' (valoare între 0 și 1).
       Cu colorarea fiecărei celule la dreapta, valoarea ponderii se înjumătățește. 
       Hint: folosiți funcția 'drawPixelAmount'.
    */
      var rows=document.querySelectorAll("tr");
      var cols=rows[row].childNodes;
      var ncols=cols.length;
      var colour=window.getComputedStyle(cols[col]).backgroundColor;
      for(let i=col+1;i<ncols;i++){
         drawPixelAmount(row,i,colour,amount);
         amount/=1.5;
      }
    }
    function clear(){
      var rows=document.querySelectorAll("tr");
      var cols=rows[0].childNodes;
      var ncols=cols.length,nrows=rows.length;
      drawRect(1,1,nrows,ncols,"whitesmoke");

    }
    
    window.onload = function(){
        const rows = 20;
        const cols = 20;	
        
        drawTable(rows, cols);
        //colorCol(2,"rgb(255, 0, 0)");
        //colorRow(5,"rgb(255, 154, 0)");
        //rainbow("col");
       /* drawPixel(5,5,"black");
        drawLine(3,2,3,7,"black");
        drawLine(10,1,15,1,"black");
        drawRect(17,17,19,19,"black");*/
        
      //drawPixelAmount(5,7,"rgb(186, 12, 248)",0.5);

        /*drawPixelExt(30,30,"black");
        colorRow(5,"black");
        delRow(5);
        colorCol(5,"black");
        delCol(5);*/

        //shiftRow(5,1);
        //jumble();
        //smear(4,5,1);
        let b=document.getElementById("curcubeu");
        b.addEventListener("click",()=>{rainbow("col")});
        let j=document.getElementById("jumble");
        j.addEventListener("click",()=>{jumble()});
        let c=document.getElementById("clear");
        c.addEventListener("click",()=>{clear()});
    }
    
    
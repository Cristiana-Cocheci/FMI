% listare_studenti(ListaStudenti, PragNota, ListareRezultat)

listare_studenti([],_,[]).
% daca lista e vida, se returneaza o lista vida
listare_studenti([student(X,Y)|T],P,[X|R]):- Y<P,listare_studenti(T,P,R).
% daca Y, adica nota, este mai mica strict decat P, se adauga numele, X, la lista rezultata
listare_studenti([student(_,Y)|T],P,R):- Y>=P, listare_studenti(T,P,R).
% altfel, se ignora studentul respectiv

%exemple
%listare_studenti([student(ionel, 8), student(maria, 10),student(gabriela, 5), student(luca, 9)], 11, R).
%R = [ionel, maria, gabriela, luca]
%listare_studenti([student(ionel, 8), student(maria, 10),student(gabriela, 5), student(luca, 9)], 1, R).
%R=[]



consec([]).
%lista e vida, deci e adevarat
consec([H]):- H>=0,floor(H,X),X=:=H.
%lista are un singur element, se verifica ca e natural
consec([H|[A|T]]):- A>=0, H=:=A+1,floor(H,X),X=:=H, consec([A|T]).
% se verifica ca primul element este aldoilea plus 1, si ca acesta e natural

%exemple
%consec([48.9,47.9])- false
%consec([56,55,54])- true
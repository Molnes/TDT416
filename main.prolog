parent(john, sue).
parent(john, mike).
parent(betty, sue).
parent(betty, mike).
parent(sue, linda).
parent(mark, linda).
male(john).
male(mike).
male(mark).
female(sue).
female(betty).
female(linda).
father(X,Y) :- parent(X,Y), male(X).
mother(X,Y) :- parent(X,Y), female(X).
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z),
ancestor(Z,Y).
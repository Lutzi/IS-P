% Autor:
% Datum: 20.10.2016

:- consult('readsentence').
:- consult('stammbaum').
:- consult('lex').


ask :-
    writeln('stell ne frage huso'),
    read_sentence(Frage),
    trim(Frag,Frage),
    verarbeiten(Frag, Sem).
    
    trim(Q,In) :- append(Q,['.'],In).

verarbeiten --> entfrag.
%High Level Shit
entfrag --> ipe, en(Sem), np, prep, en(Sem), {call(Sem)}.
%ergfrag -->.

  %Basic Shit
np --> art(N), nom(N, Sem).
%np --> art(N), nom(N, Sem), ppp.
%np --> en.

ppp --> pp, np.

vp --> v.
vp --> v, np.

%Lexikonzugriff
art(N)      --> [X], {lex(X,_,art,N)}.
nom(N, Sem) --> [X], {lex(X,Sem,n,N)}.
ut          --> [X], {lex(X,_,ut,_)}.
prep        --> [X], {lex(X,_,prep,_)}.
verb        --> [X], {lex(X,_,v,_)}.
ip        --> [X], {lex(X,_,ip,_)}.
ipe        --> [X], {lex(X,_,ipe,_)}.
en(Sem)        --> [X], {lex(X,Sem,name,_)}.

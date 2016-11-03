% Autor:
% Datum: 20.10.2016

:- consult('readsentence').
:- consult('stammbaum').
:- consult('lex').


ask :-
    writeln('stell ne frage huso'),
    read_sentence(Frage),
    trim(Frag,Frage),
    verarbeiten(Sem, Frag, []).

    
    
trim(Q,In) :- append(Q,['?'],In).

verarbeiten(Sem) --> entfrag(Sem),
                 {Final =.. Sem},
                 {call(Final)},
                 {write('Ja, er/sie ist der/die Vater/Mutter/Tochter/Sohn von ihm/ihr')}.
verarbeiten(Sem) --> ergfrag(Sem),
                 {Term =.. Sem,
                 call(Term),
                 nth1(2, Sem, Elem),
                 write('keine frage, du sprichst von '), write(Elem)}.

%High Level Shit

%entfrag(Sem) --> ipe, en(SemA), np(SemNP), prep, en(SemB),
%             {Sem = [SemNP,SemA,SemB]}.
%ergfrag(Sem) --> ip(SemIP), vp(SemVP), prep, en(SemA),
%             {Sem = [SemVP,SemIP,SemA]}.
%Basic Shit
%np(Sem) --> art(N), nom(N, Sem).
%ppp --> pp, np.
%vp(Sem) --> verb, np(SemNP), {Sem = SemNP}.

entfrag(Sem) --> ipe, en(SemA), np(SemNP),
             {SemNP = [A|B], B = [C|D], Sem = [A, SemA, C]}.

np(Sem) --> en(Sem).
np(Sem) --> art, nom(Sem).
np(Sem) --> art, nom(SemN), pp(SemPP),
        {Sem = [SemN,SemPP]}.

pp(Sem) --> prep, np(Sem).

vp(Sem) --> verb.
vp(Sem) --> verb, np(SemNP),
        {Sem = SemNP}.


%Lexikonzugriff
art(N)      --> [X], {lex(X,_,art,N)}.
nom(N, Sem) --> [X], {lex(X,Sem,n,N)}.
ut          --> [X], {lex(X,_,ut,_)}.
prep        --> [X], {lex(X,_,prep,_)}.
verb        --> [X], {lex(X,_,v,_)}.
ip(Sem)        --> [X], {lex(X,Sem,ip,_)}.
ipe        --> [X], {lex(X,_,ipe,_)}.
en(Sem)        --> [X], {lex(X,Sem,name,_)}.

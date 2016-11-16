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

test :- findall(X, ist_schwester_von(X, schmutz),L),
     write(L).
    
    
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

% Ist Lutz der Vater von Schmutz?
entfrag(Sem) --> ipe, en(SemA), np(SemNP),
             {SemNP = [A|B], B = [C|_], Sem = [A, SemA, C]}.  % so halb auf Verschachtelung ausgelegt, aber funktioniert dafür nicht...

% Wer ist der Vater von Schmutz?
ergfrag(Sem) --> ip(SemIP), vp(SemVP), pp(SemPP),
             {Sem = [SemVP,SemIP,SemPP]}.
             
% Wer sind die Schwestern von Schmutz?
p_ergfrag(Sem) --> ip(SemIP), vp(SemVP), pp(SemPP),
             {Sem = [SemVP,SemIP,SemPP]}.

% Basic
np(Sem) --> en(Sem).
np(Sem) --> art(N), nom(N, Sem).
np(Sem) --> art(N), nom(N, SemN), pp(SemPP),
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

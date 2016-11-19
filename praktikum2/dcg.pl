% Autor:
% Datum: 20.10.2016

:- consult('readsentence').
:- consult('stammbaum').
:- consult('lex').


ask :-
    writeln('stell ne frage'),
    read_sentence(Frage),
    trim(Frag,Frage),
    verarbeiten(Sem, Frag, []),
    writeln(''),
    ask.

test :- findall(X, ist_schwester_von(X, schmutz),L),
     write(L).
    
    
trim(Q,In) :- append(Q,['?'],In).

verarbeiten(Sem) --> entfrag(Sem),
                 {Final =.. Sem},
                 {call(Final)},
                 {write('Ja, er/sie ist der/die Vater/Mutter/Tochter/Sohn von ihm/ihr')}.
verarbeiten(Sem) --> ergfrag(Sem, s),
                 {Term =.. Sem,
                 call(Term),
                 nth1(2, Sem, Elem),
                 write('keine frage, du sprichst von '), write(Elem)}.
                 
verarbeiten(Sem) --> ergfrag(Sem, p),
                 {%write(Sem),
                 nth1(2, Sem, X),
                 Term =.. Sem,
                 findall(X, Term,L),
                 write('Das sind '),
                 print_all(L)}.

print_all([]).
print_all([X|Rest]) :- write(X),write(' '), print_all(Rest).

% Fragetypen

% Ist Lutz der Vater von Schmutz?
entfrag(Sem) --> ipe, en(SemA), np(SemNP, N),
             {SemNP = [A|B], B = [C|_], Sem = [A, SemA, C]}.  % so halb auf Verschachtelung ausgelegt, aber funktioniert dafür nicht...

% Wer ist der Vater von Schmutz?
% Wer sind die Schwestern von Schmutz?
ergfrag(Sem,N) --> ip(SemIP), vp(SemVP, N), pp(SemPP,_),
             {Sem = [SemVP,SemIP,SemPP]}.

% Basic
np(Sem, N) --> en(Sem).
np(Sem, N) --> art(N), nom(N, Sem).
np(Sem, N) --> art(N), nom(N, SemN), pp(SemPP, N),
        {Sem = [SemN,SemPP]}.

pp(Sem, N) --> prep, np(Sem, N).

vp(Sem, N) --> verb(N).
vp(Sem, N) --> verb(N), np(SemNP, N),
        {Sem = SemNP}.


%Lexikonzugriff
art(N)      --> [X], {lex(X,_,art,N)}.
nom(N, Sem) --> [X], {lex(X,Sem,n,N)}.
ut          --> [X], {lex(X,_,ut,_)}.
prep        --> [X], {lex(X,_,prep,_)}.
verb(N)        --> [X], {lex(X,_,v,N)}.
ip(Sem)        --> [X], {lex(X,Sem,ip,_)}.
ipe        --> [X], {lex(X,_,ipe,_)}.
en(Sem)        --> [X], {lex(X,Sem,name,_)}.

% Autor:
% Datum: 20.10.2016

:- consult('readsentence').
:- consult('stammbaum').
:- consult('lex').


ask :-
    writeln('stell ne frage'),
    read_sentence(Frage),
    trim(Frag,Frage),
    verarbeiten(Frag, []).

test :- Frage1 = [ist,lola,die,mutter,von,schmutz],
     Frage2 = [wer,sind,die,schwestern,von,schmutz],
     Frage3 = [wer,ist,der,vater,von,schmutz],
     Frage4 = [wer,ist,der,bruder,von,sebille],
     Frage5 = [wer,sind,die,brüder,von,sebille],
     verarbeiten(Frage1,[]),
     verarbeiten(Frage2,[]),
     verarbeiten(Frage3,[]),
     verarbeiten(Frage4,[]),
     verarbeiten(Frage5,[]),
     writeln('Tests erfolgreich, alles gut!').
    
    
trim(Q,In) :- append(Q,['?'],In).

verarbeiten --> entfrag(Sem, Art, Beziehung),
                 {Final =.. Sem},
                 {call(Final)},
                 {write('Ja, das ist '), write(Art), write(' '),write(Beziehung), writeln('.')}.
%verarbeiten --> ergfrag(Sem, s),
  %               {Term =.. Sem,
     %            call(Term),
            %     nth1(2, Sem, GesuchtePerson),
               %  write('Keine Frage, du sprichst von '), writeln(GesuchtePerson)}.
                 
verarbeiten --> ergfrag(Sem,_),
                 {nth1(2, Sem, X),
                 nth1(1, Sem, Verhaeltnis),
                 Term =.. Sem,
                 findall(X, Term,L),
                 ausgabe(L,Verhaeltnis)}.

print_all([A|[]]) :- write(A), writeln('.').
print_all([X|Rest]) :- write(X),write(' und '), print_all(Rest).

ausgabe([],Verhaeltnis) :- write('Es wurde niemand gefunden.').
ausgabe([A|[]],Verhaeltnis) :- lex(Art,_,art,s,G),write(Art), write(' '), lex(Nomen,Verhaeltnis,n,s,G), write(Nomen), write(' ist '), writeln(A).
ausgabe([A|B],Verhaeltnis) :- lex(Art,_,art,p,G),write(Art), write(' '), lex(Nomen,Verhaeltnis,n,p,G), write(Nomen), write(' sind '), X = [A|B], print_all(X).

% Fragetypen

% Ist Lutz der Vater von Schmutz?
entfrag(Sem, Art, Beziehung) --> ipe, en(SemA), np(SemNP, N, Art, Beziehung),
             {SemNP = [A|B], B = [C|_], Sem = [A, SemA, C]}.  % so halb auf Verschachtelung ausgelegt, aber funktioniert dafür nicht...

% Wer ist der Vater von Schmutz?
% Wer sind die Schwestern von Schmutz?
ergfrag(Sem,N) --> ip(SemIP), vp(SemVP, N), pp(SemPP,_),
             {Sem = [SemVP,SemIP,SemPP]}.

% Basic
np(Sem, N, Art, Beziehung) --> en(Sem).
np(Sem, N, Art, Beziehung) --> art(N, Art,_), nom(N, Sem, Beziehung,_).
np(Sem, N, Art, Beziehung) --> art(N, Art,_), nom(N, SemN, Beziehung,_), pp(SemPP, N),
        {Sem = [SemN,SemPP]}.

pp(Sem, N) --> prep, np(Sem, N, Art, Beziehung).

vp(Sem, N) --> verb(N).
vp(Sem, N) --> verb(N), np(SemNP, N, Art, Beziehung),
        {Sem = SemNP}.


%Lexikonzugriff
art(N, X, G)      --> [X], {lex(X,_,art,N,G)}.
nom(N, Sem, X, G) --> [X], {lex(X,Sem,n,N,G)}.
%ut          --> [X], {lex(X,_,ut,_)}.
prep        --> [X], {lex(X,_,prep,_)}.
verb(N)        --> [X], {lex(X,_,v,N)}.
ip(Sem)        --> [X], {lex(X,Sem,ip,_)}.
ipe        --> [X], {lex(X,_,ipe,_)}.
en(Sem)        --> [X], {lex(X,Sem,name,_)}.

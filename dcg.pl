% Autor:
% Datum: 20.10.2016

% :- ensure_loaded([dictionary]).
:- consult('readsentence').
:- consult('stammbaum').


ask :-
    writeln('Ask a question'),
    read_sentence(In),
    % trim(Q,In),
    processInput(In).
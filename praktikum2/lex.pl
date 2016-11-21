% Autor:
% Datum: 20.10.2016

% lex(wort,semantik,wortart,numerus, genus)
lex(wer,X,ip,_).
lex(ist,_,ipe,s).
lex(sind,_,ipe,p).

lex(ist,_,v,s).
lex(sind,_,v,p).

lex(schwester, ist_schwester_von, n, s, w).
lex(schwestern, ist_schwester_von, n, p, w).
lex(bruder, ist_bruder_von, n, s, m).
lex(brüder, ist_bruder_von, n, p, m).
lex(onkel, ist_onkel_von, n, s, m).
lex(tante, ist_tante_von, n, s, w).
lex(vater, ist_vater_von, n, s, m).
lex(mutter, ist_mutter_von, n, s, w).
lex(sohn, ist_sohn_von, n, s, m).
lex(tochter, ist_tochter_von, n, s, w).
lex(neffe, ist_neffe_von, n, s, m).
lex(halbschwester, ist_halbschwester_von, n, s, w).
lex(kinder, ist_kinder_von, n, p, n).

lex(der,_,art,s, m).
lex(die,_,art,s, w).
lex(die,_,art,p,_).
lex(das,_,art,s, n).

lex(von,_,prep,_).

%lex(ein, _, ut, s).
%lex(eine, _, ut, s).

lex(Name,Name,name,s):-maennlich(Name);weiblich(Name).

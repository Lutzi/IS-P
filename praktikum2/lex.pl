% Autor:
% Datum: 20.10.2016

% lex(wort,semantik,wortart,numerus)
lex(wer,X,ip,_).
lex(ist,_,ipe,s).
lex(sind,_,ipe,p).

lex(ist,_,v,s).
lex(sind,_,v,p).

lex(schwester, ist_schwester_von, n, s).
lex(schwestern, ist_schwester_von, n, p).
lex(bruder, ist_bruder_von, n, s).
lex(brüder, ist_bruder_von, n, p).
lex(onkel, ist_onkel_von, n, s).
lex(tante, ist_tante_von, n, s).
lex(vater, ist_vater_von, n, s).
lex(mutter, ist_mutter_von, n, s).
lex(sohn, ist_sohn_von, n, s).
lex(tochter, ist_tochter_von, n, s).
lex(neffe, ist_neffe_von, n, s).
lex(halbschwester, ist_halbschwester_von, n, s).
lex(kinder, ist_kinder_von, n, p).

lex(der,_,art,s).
lex(die,_,art,s).
lex(die,_,art,p).
lex(das,_,art,s).

lex(von,_,prep,_).

lex(ein, _, ut, s).
lex(eine, _, ut, s).

lex(Name,Name,name,s):-maennlich(Name);weiblich(Name).


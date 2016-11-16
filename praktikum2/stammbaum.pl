% Autor:
% Datum: 30.09.2016

:-consult('readsentence.pl').

maennlich(hugo). maennlich(amon). maennlich(lutz). maennlich(putz). maennlich(schmutz).
maennlich(michael).
weiblich(lily). weiblich(sebille). weiblich(swetlana). weiblich(stefana). weiblich(annika). weiblich(berta). weiblich(lola).

ist_elter_von(lily,sebille).
ist_elter_von(hugo,sebille).
ist_elter_von(lutz,schmutz).
ist_elter_von(lutz,berta).
ist_elter_von(lutz,annika).
ist_elter_von(lola,schmutz).
ist_elter_von(lola,berta).
ist_elter_von(lola,annika).
ist_elter_von(hugo,lutz).
ist_elter_von(hugo,putz).
ist_elter_von(swetlana,lutz).
ist_elter_von(swetlana,putz).
ist_elter_von(stefana,amon).
ist_elter_von(putz,michael).

ist_vater_von(X,Y):-maennlich(X),ist_elter_von(X,Y).
ist_schwester_von(X,Y):-weiblich(X),ist_geschwister_von(X,Y).
ist_mutter_von(X,Y):-weiblich(X),ist_elter_von(X,Y).
ist_sohn_von(X,Y):-maennlich(X),ist_elter_von(Y,X).
ist_tochter_von(X,Y):-weiblich(X),ist_elter_von(Y,X).
ist_geschwister_von(X,Y):-ist_vater_von(V,X),ist_vater_von(V,Y),
   ist_mutter_von(M,X),ist_mutter_von(M,Y),X \=Y.
ist_halbgeschwister_von(X,Y):-(ist_vater_von(V,X),ist_vater_von(V,Y);
   ist_mutter_von(M,X),ist_mutter_von(M,Y)), not(ist_geschwister_von(X,Y)), X \= Y.
ist_halbschwester_von(X,Y):-ist_halbgeschwister_von(X,Y),weiblich(X).
ist_cousin_von(X,Y):- ist_elter_von(A,X), ist_elter_von(B,Y), ist_geschwister_von(A,B), maennlich(X), X \= Y.
ist_neffe_von(X,Y):- ist_elter_von(A,X),ist_geschwister_von(A,Y),maennlich(X).
ist_nicht_weiblich(X):-maennlich(X), not(weiblich(X)).



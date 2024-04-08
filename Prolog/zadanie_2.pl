:- set_prolog_flag(occurs_check, error).
:- set_prolog_stack(global, limit(8 000 000)).
:- set_prolog_stack(local, limit(2 000 000)).


mezczyzna(janusz).
mezczyzna(brajan).
mezczyzna(piotr).

mezczyzna(adam).
mezczyzna(kuba).

mezczyzna(kamil).
mazczyzna(szymon).
mezczyzna(ezekiel).


rodzic(janusz, piotr).
rodzic(janusz, brajan).
rodzic(grazyna, piotr).
rodzic(grazyna, brajan).

rodzic(piotr, adam).
rodzic(adam, magda).
rodzic(emilia, magda).
rodzic(magda,mia).
rodzic(kuba,mia).
rodzic(kuba, ezekiel).
rodzic(adelaida, ezekiel).

rodzic(brajan, kamil).
rodzic(martyna,kamil).

rodzic(kamil,adelaida).
rodzic(abigail,adelaida).


osoba(grazyna).
osoba(emilia).
osoba(martyna).
osoba(abigail).
osoba(adelaida).
osoba(magda).
osoba(mia).
/*
?-kobieta(magda).
?- ojciec(janusz,brajan).
?- matka(grazyna,piotr).
?- corka(magda,adam).
?- brat_rodzony(piotr,brajan).
?- brat_przyrodni(ezekiel, mia).
?- kuzyn(kamil,adam).
?- dziadek_od_strony_ojca(janusz,adam).
?- dziadek_od_strony_matki(kamil,ezekiel).
?- dziadek(piotr,magdy).
?- babcia(abigail, ezekiel).
?- wnuczka(emilia,mia).
?- przodek_do2pokolenia_wstecz(piotr,mia).
?- przodek_do3pokolenia_wstecz(janusz,mia).
*/
kobieta(X) :- 
    \+ mezczyzna(x).

ojciec(X,Y) :-% X jest ojcem Y
    mezczyzna(X),
    rodzic(X, Y),
    X =\ Y.

matka(X,Y) :-% X jest matką Y
    kobieta(X),
    rodzic(X, Y),
    X =\ Y.

corka(X, Y) :-% X jest córką Y
    kobieta(X),
    rodzic(Y, X),
    X \= Y.

brat_rodzony(X, Y) :-% X jest rodzonym bratem Y
    mezczyzna(X),
    (ojciec(Z, X), ojciec(Z, Y)),
    (matka(W, X), matka(W, Y)).

siostra_rodzona(X, Y) :-
    kobieta(X),
    (ojciec(Z, X), ojciec(Z, Y)),
    (matka(W, X), matka(W, Y)).

brat_przyrodni(X, Y) :-% X jest przyrodnim bratem Y
    mezczyzna(X),
    (
        (
            (ojciec(Z, X), ojciec(Z, Y)), (matka(W, X), matka(U, Y))
        );
        (
            (ojciec(Z, X), ojciec(R, Y)), (matka(W, X), matka(W, Y))
        )
    )

kuzyn(X, Y) :-% X jest kuzynem Y
    rodzic(Z, X),
    rodzic(W, Y),
    (
        brat_rodzony(Z, W);
        siostra_rodzona(W, Z);
        siostra_rodzona(Z, W);
    ),
    Z =\ W.

dziadek_od_strony_ojca(X,Y) :–% X jest dziadkiem od strony ojca dla Y
    ojciec(X, Z),
    ojciec(Z, Y),
    X =\ Y.

dziadek_od_strony_matki(X,Y) :–% X jest dziadkiem od strony matki dla Y
    ojciec(X, Z),
    matka(Z, Y),
    X =\ Y.

dziadek(X,Y) :–% X jest dziadkiem Y
    ojciec(X, Z),
    rodzic(Z, Y),
    Z =\ Y,
    X =\ Y.

babcia(X,Y) :–% X jest babcią Y
    matka(X, Z),
    rodzic(Z, Y),
    Z =\ Y,
    X =\ Y.

wnuczka(X,Y) :–% Y jest wnuczką X
    kobieta(Y),
    (
        babcia(X, Y);
        dziadek(X, Y)
    ).

przodek_do2pokolenia_wstecz(X,Y) :–% X jest przodkiem Y do drugiego pokolenia wstecz
    rodzic(Z, Y),
    (
        dziadek(X, Z);
        babcia(X, Z)
    ),
    X =\ Y.
    
przodek_do3pokolenia_wstecz(X,Y) :-% X jest przodkiem Y do trzeciego pokolenia wstecz
    rodzic(Z,Y),
    przodek_do2pokolenia_wstecz(X,Z),
    X =\ Y.

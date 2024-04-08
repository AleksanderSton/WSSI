:- set_prolog_flag(occurs_check, error).
:- set_prolog_stack(global, limit(8 000 000)).
:- set_prolog_stack(local, limit(2 000 000)).

lubi(jan, pawel).
lubi(pawel, krzysztof).
lubi(pawel, jan).
lubi(jan, bartek).
lubi(bartek, jan).
lubi(patrycja, kuba).
lubi(kuba, patrycja).
lubi(adam, filip).
lubi(filip, adam).

mezczyzna(jan).
mezczyzna(pawel).
mezczyzna(bartek).
mezczyzna(filip).
mezczyzna(adam).
mezczyzna(kuba).

kobieta(patrycja).

przyjazn(X, Y) :-
    lubi(X, Y),
    lubi(Y, X).

niby_przyjazn(X, Y) :-
    lubi(X, Y);
    lubi(Y, x).

nieprzyjazn(X, Y) :-
    \+ (lubi(X, Y)),
    \+ (lubi(X, Y)).

love(X, Y) :-
    przyjazn(X, Y),
    \+ (lubi(X, Z), Z \= Y),
    \+ (lubi(Y, W), W \= X).

true_love(X, Y) :-
    love(X, Y),
    (mezczyzna(X) \= mezczyzna(Y)).
/*
?- love(filip, adam).
?- love(patrycja, kuba).
?- true_love(patrycja, kuba).
?- przyjazn(jan, pawel).
?- niby_przyjazn(pawel, krzysztof).
?- nieprzyjazn(krzysztof, jan).
 * /

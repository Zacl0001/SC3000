prince(X) :- male(X).
princess(X) :- female(X).

male(charles).
male(andrew).
male(edward).
female(ann).
female(elizabeth).
queen(elizabeth).

offspring_of(charles, elizabeth).
offspring_of(ann, elizabeth).
offspring_of(andrew, elizabeth).
offspring_of(edward, elizabeth).

older_than(charles, ann).
older_than(ann, andrew).
older_than(andrew, edward).

% check for older than relation first, or check for transitive older relation
older(X, Y) :- older_than(X, Y).
older(X, Y) :- older_than(X, Z), older(Z, Y).

%Older male first
succession(X,Y):- prince(X), prince(Y), older(X, Y), !.

%Male before female
succession(X,Y) :- prince(X), princess(Y), !.

%Older female first
succession(X,Y) :- princess(X), princess(Y), older(X,Y), !.

succession(_,_) :- fail.

% to find line of succession
compare_succession(<, X, Y) :- succession(X,Y), !.
compare_succession(>, X, Y) :- succession(Y,X), !.
compare_succession(=, _, _).

line_of_succession_list(Ordered) :-
  findall(P, offspring_of(P, elizabeth), L),
  predsort(compare_succession, L, Ordered).

line_of_succession(X) :-
    line_of_succession_list(Ordered),
    member(X, Ordered).


%only birth order related knowledge needed, gender knowledge removed
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

% birth order only criteria
succession(X,Y) :- older(X, Y), !.

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

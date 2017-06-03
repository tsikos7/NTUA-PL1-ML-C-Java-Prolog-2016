read_and_return(File, Map) :-
  open(File, read, Stream),
  read_line(Stream, Weights),
  length(Weights, L),

main :-
  open(File, read, Str),
  read_file(Str,Lines),
  close(Str),
  write(Lines), nl.

read_file(Stream,[]) :-
  at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
  \+ at_end_of_stream(Stream),
  read(Stream,X),
  read_file(Stream,L).

read_line(Stream, List) :-
  read_line_to_codes(Stream, Line),
  atom_codes(A, Line),
  atomic_list_concat(As, ' ', A),
  maplist(atom_number, As, List).

list_min([L|Ls], Min) :- foldl(num_num_min, Ls, L, Min). /*http://stackoverflow.com/a/3966139*/
num_num_min(X, Y, Min) :- Min is min(X, Y).

list_max([L|Ls], Max) :- foldl(num_num_max, Ls, L, Max).
num_num_max(X, Y, Max) :- Max is max(X, Y).

sum_list([],0).
sum_list([H|T],S):- sum_list(T,R), S is H+R.

fair_parts(Name,Mini,Maxi,Suma,X,Y,NS):-
	main(Name,N,W),
	list_min(W,Mini),
	list_max(W,Maxi),
	sum_list(W,Suma),
	NS is Suma/N,
	X is Mini,
	(NS<Maxi -> Y is Maxi; Y is NS).

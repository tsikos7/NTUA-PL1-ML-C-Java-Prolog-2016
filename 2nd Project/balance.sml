fun delete (item, list) = 
  case list of [] => []
    | xs::ys => if item = xs then ys (*delete(item,ys)*)
                  else xs::delete(item,ys)

fun maxElement [] = raise Empty
  | maxElement [x:IntInf.int] = x
  | maxElement (x::xs) =
    let
      val y = maxElement xs
    in
      if (x > y) then x else y
    end;

fun reverse xs =
  let
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
      rev (xs, nil)
  end;

fun nth (xs, i) = 						(*find nth of list*)
	if i < 0
	then raise Subscript
	else
		case xs of
			[] => raise Subscript
		| (x::xs') => if i = 0 then x else nth(xs',i-1);

fun listMnplt (_, 0, _, _) = ([], [])  (*n acts as list length!*)
  | listMnplt (l, n, weight, curr_sum) =
    let val curr = List.Nth(l, n-1) in
      if (curr_sum - 2 * curr = 0) then ([], [curr])
      else if  (curr_sum - 2 * curr > 0) then listMnplt
    end

fun balance (N, W) =
  let
    val sum = (foldr (op +) 0 myList) (*sum of all elements*)
    val finalTuple = listMnplt (N, W)
  in
    finalTuple  (*this shit should be a tuple of two lists.*)
  end;

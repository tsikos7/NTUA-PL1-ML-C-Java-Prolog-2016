fun maxElement [] = raise Empty
  | maxElement [x:IntInf.int] = x
  | maxElement (x::xs) =
    let
      val y = maxElement xs
    in
      if (x > y) then x else y
    end;
(*
fun reverse xs =
  let
    let val (x, y) = halve cs in
      (a::x, b::y)
    end
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
      rev (xs, nil)
  end;*)

fun nth (xs, i) = 						(*find nth of list*)
	if i < 0
	then raise Subscript
	else
		case xs of
			[] => raise Subscript
		| (x::xs') => if i = 0 then x else nth(xs',i-1);

fun halve nil = (nil, nil)
  | halve [a] = ([a], nil)
  | halve (a::b::cs) =
    let val (x, y) = halve cs in
      (a::x, b::y)
    end;

fun merge1 (nil, ys) = ys
  | merge1 (xs, nil) = xs
  | merge1 ((x: (int * int * int))::xs, (y: (int * int * int))::ys) =
    if (#1 x) < (#1 y) then x :: merge1 (xs, y::ys)
      else y :: merge1 (x::xs, ys);

fun merge2 (nil, ys) = ys
  | merge2 (xs, nil) = xs
  | merge2 ((x: (int * int * int))::xs, (y: (int * int * int))::ys) =
    if (#2 x) < (#2 y) then x :: merge2 (xs, y::ys)
      else y :: merge2 (x::xs, ys);

fun mergeSort (nil, _) = nil
  | mergeSort ([a], _) = [a]
  | mergeSort (theList, 1) =
    let  val (x, y) = halve theList  in
      merge1 (mergeSort (x, 1), mergeSort (y, 1))
    end
  | mergeSort (theList, 2) =
    let  val (x, y) = halve theList  in
      merge2 (mergeSort (x, 2), mergeSort (y, 2))
    end;

fun findNextLim (l1: (int * int * int) list, l2: (int * int * int) list) =
  let
    val h1 = hd(l1)
    val h2 = hd(l2)
  in
      if (#1 h1) < (#2 h2) then
        (#1 h1, #3 h1, 1)          (*first case, nextLim is a bottom one*)
      else
        (#2 h2, #3 h2, 2)                               (*second case, nextLim is a top one*)
  end;  (*it returns (height, area, case number)*)
(*
fun findNextLim (l1: (int * int * int) list, l2: (int * int * int) list) =
  let
    val h1 = hd(l1)
    val h2 = hd(l2)
  in
      if (#1 h1) < (#2 h2) then
        if tl(l1) = nil then
          (#2 h2, #3 h2, 2)
        else
          (#1 h1, #3 h1, 1)          (*first case, nextLim is a bottom one*)
      else
        if tl(l2) = nil then
          (#1 h1, #3 h1, 1)          (*first case, nextLim is a bottom one*)
        else
          (#2 h2, #3 h2, 2)                               (*second case, nextLim is a top one*)
  end;  (*it returns (height, area, case number)*)
*)

fun findSolution (nil, nil, _, _, _) = ~1.0
  | findSolution (nil, topList, vol, area, curr) =
    if (vol - ((#2 (hd(topList))) - curr) * area > 0) then
      findSolution (nil, tl(topList), vol - ((#2 (hd(topList))) - curr) * area, area - #3 (hd(topList)), #2 (hd(topList)))
    else
      (real curr) + (real vol) / (real area)
  | findSolution (_, nil, _, _, _) = ~1.0 (*OVERFLOW CASES!!*)
  | findSolution (baseList, topList, vol, area, curr) =
    let
      val nextLim = #1 (findNextLim (baseList, topList))
      val temp = findNextLim (baseList, topList)
      val c = #3 temp
      val newArea = #2 temp
      val vol' = vol - (nextLim - curr) * area
    in
      if (vol' > 0) then
        if c = 1 then (*then nextLim is a bottom one*)
          findSolution (tl(baseList), topList, vol', area + newArea, nextLim)
        else
          findSolution (baseList, tl(topList), vol', area - newArea, nextLim)
      else
        let val res = (Real.fromInt curr) + (Real.fromInt vol) / (Real.fromInt area) in
          if res > real (#2 (List.last(topList))) then
            ~1.0
          else
            res
        end
    end;

fun deksamenes filename =
  let
  (*LET'S GET THAT DATA*)
  (*val filename = "ni.txt"*)
  val fstream = TextIO.openIn filename
  fun int_from_stream stream =
    (Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) stream))
  fun read_ints 0 = nil
    | read_ints n = ((int_from_stream fstream) :: []) @ (read_ints (n-1))
  fun read_lines 0 = nil
    | read_lines n =
      let val line = read_ints 4 val temp = nth(line, 0) in
        (nth(line, 0), (nth(line, 0) + nth(line, 1)), nth(line, 2) * nth(line, 3)) :: read_lines (n-1) (*list of 3-tuples*)
      end                         (*TUPLE: starting height, ending height, area*) (*volume = area * height*)
  val N = int_from_stream fstream;
  val myList = read_lines N;
  val volume = int_from_stream fstream;
  (*WE GOT THE DATA*)
  val l1 = mergeSort (myList, 1); (*based on starting height*)
  val l2 = mergeSort (myList, 2); (*based on ending height*)
  val startingArea = #3 (hd(l1));
  val startingHeight = #1 (hd(l1));
  val result = findSolution(tl(l1), l2, volume, startingArea, startingHeight);

in
  result
end;

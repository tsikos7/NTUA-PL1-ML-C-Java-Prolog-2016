
(*val filename = "foo";*)
(*hd(CommandLine.arguments())*)


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


fun checkSumHelper (l, 0, k, sum:IntInf.int) =
    if sum + nth(l, 0) <= k then (*(print(">> sum = " ^ Int.toString sum ^ ", checkSumHelper returning with 1\n");*) 1
    else (*(print(">> sum = " ^ Int.toString sum ^ ", checkSumHelper returning with 2\n");*) 2
  | checkSumHelper (l, n, k, sum) =
    let
      val temp = (nth(l, (Int.fromLarge n)))
    in
      if (*)(nth(l, n) + nth(l, n-1))*) sum + nth(l, Int.fromLarge n) <= k then
        (*(print("> checkSumHelper recursion with k = " ^ Int.toString k ^ " new sum = " ^ Int.toString (sum+temp) ^ " new n = " ^ Int.toString (n-1) ^ "\n");*)
        checkSumHelper (l, n-1, k, sum + temp)
      else
        (*(print(">> checkSumHelper returning with " ^ Int.toString (n+1) ^ "\n"); *) n+1  (*returns position after which error = true*)
    end;

fun checkSum (l, j, solution:IntInf.int, pcs, pieces) =
  if (j > 0 andalso pcs <= pieces) then
    (*if checkSumHelper (l, j, solution, 0) > 0 then*)
    (*)(print(">> starting point = " ^ Int.toString j ^ ", pcs = " ^ Int.toString pcs ^ "\n");*)
    checkSum (l, checkSumHelper (l, j, solution, 0)-1, solution, pcs + 1, pieces)
  else if (j = 0 andalso pcs <= pieces+1) then(*)(print("> j = " ^ Int.toString j ^ " > checkSum returning true!\n"); *)(true, pcs)
  else (*(print("> j = " ^ Int.toString j ^ " > checkSum returning false!\n");*) (false, pcs);

fun tempBool1 (a, b) =  (*pcs>=pieces in checkSum??*)
  if a then true
  else false;

fun tempBool2 ((a, b), pieces, len) = (*can we fit the separators??*)
  if (len - b <= pieces) then true
  else false;

fun checkSolution (l, len, solution:IntInf.int, pieces) =
  let
    val error = false
    val i = len - 1
    val sum = 0
    val tup = checkSum(l, i, solution, 1, pieces)
  in
    if (tempBool1(tup) = false) (*orelse (tempBool2 (tup, pieces, len) = false)*) then
      (*)(print("> solution is false\n");*) false
    else
      (*print("> solution is true\n");*) true
  end;

fun binarySearch (l, lb:IntInf.int, ub:IntInf.int, solution:IntInf.int, len, pieces) =
  let
    val min_max = (lb + ub) div 2
  in
    (*if ub - lb <= 1 then solution*)
    if ub - lb > 1 then
      if checkSolution (l, len, min_max, pieces) then
        (*(print("> working min_max = " ^ (Int.toString min_max) ^ "\n");*)
        binarySearch (l, lb, min_max, min_max, len, pieces)
      else (*)(print("poulo " ^ "min_max = " ^ Int.toString min_max ^ "\n");*)
        binarySearch (l, min_max, ub, solution, len, pieces)
    else
      if checkSolution (l, len, lb, pieces) then (*print("bitch with lb = " ^ Int.toString lb ^ "\n");*) lb  (*case where we have to close in*)
      else solution
  end;    (*only if solution can be applied should we keep it!*)

fun makeSolString (l, lim, solution, pcs, pieces, recursion) =
  let
    val num = checkSumHelper (l, lim - 1, solution , 0)
    val l' = List.drop (l, Int.fromLarge num)
  in
    if num < pieces - pcs andalso pcs < pieces then
      (*(print("> mpika arakse\n");*)
      String.concatWith " | " (map IntInf.toString (List.take (l, Int.fromLarge (pieces-pcs+1)))) ^ " " ^ String.concatWith " " (map IntInf.toString (List.drop (l, Int.fromLarge (pieces-pcs+1))))
    else if pcs = pieces then
    let
      val s = String.concatWith " " (map IntInf.toString l)
    in
      (*(print(">>> reached pieces, num = " ^ Int.toString num ^ "\n");*) s
    end
    else if recursion <= pieces andalso num >= 1 (*andalso num >= pieces - pcs*) then
    let
      val l' = List.drop (l, Int.fromLarge num)
      val temp1 = nth (l, 0)
      val temp2 = nth (l, 1)
    in
      (*(print(">>> lim-1 = " ^ Int.toString (lim-1) ^ "\n");*)
      (*print(">>> nigga... pcs = " ^ Int.toString pcs ^ ", num = " ^ Int.toString num ^ " @ recursion #" ^ Int.toString recursion (* ^ ", will call csh with lim-1 = " ^ Int.toString (lim-num-2)*) ^ "\n");*)
      (*print("l = " ^ String.concatWith " " (map Int.toString l) ^ "\n");*)
      if (pcs = pieces - 1) andalso num = 2 andalso lim <= 3 then
        IntInf.toString temp1 ^ " | " ^ IntInf.toString temp2 ^ " " ^ (String.concatWith " " (map IntInf.toString l'))
      else
      makeSolString (List.take (l, Int.fromLarge num), num, solution, pcs + 1, pieces, recursion + 1) ^ " | " ^ (String.concatWith " " (map IntInf.toString l'))
    end
    else (*)(print(">>> num = " ^ Int.toString num ^ ", lim = " ^ Int.toString lim ^ "\n");*) ""
    (*so some serious shit*)
    (*([~1] :: List.take (reverse l, num)) @ makeSolString (l, input_size - num, solution, pcs + 1, pieces)*)
  end;


(*val infile = "fair_in.txt";*)
(*val args = CommandLine.arguments()*)
(*fun sum l = foldr op+ 0 (map (valOf o Int.fromString) l)*)
(*print(explode(CommandLine.arguments()));*)
(*print(filename);*)

fun fair_parts filename =
  let
    val fstream = TextIO.openIn filename
    fun int_from_stream stream =
      Int.toLarge (Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) stream))
    fun read_ints 0 = nil
      | read_ints n = ((int_from_stream fstream) :: []) @ (read_ints (n-1))
    val input_size = (int_from_stream fstream);
    val pieces = int_from_stream fstream;
    val myList = read_ints input_size
    val myRevList = reverse myList
    val lower_bound = (maxElement myList)
    val upper_bound = (foldr (op +) 0 myList)

    val solution = (lower_bound + upper_bound) div 2 (*just so the declaration will not kick*)


    val solution = binarySearch (myList, lower_bound, upper_bound, solution, input_size, Int.fromLarge pieces)
    (*val upper_bound = foldr (op +) 0 myList;*)

    val finalString = makeSolString (myList, input_size, solution, 1, pieces, 0)

    (*val _ = OS.Process.exit(OS.Process.success);*)
  in
    finalString
  end;
    (*val _ = print ("size: " ^ Int.toString (length args) ^ "\n")
    val _ = print ("sum: " ^ Int.toString (sum args) ^ "\n")
    val _ = OS.Process.exit(OS.Process.success)*)
    (*openIn(infile);
    val input_size = TextIO.getInt(infile);
    val pieces = TextIO.getInt(infile);
    print(Int.toString(pieces));
    closeIn("fair_in.txt");*)

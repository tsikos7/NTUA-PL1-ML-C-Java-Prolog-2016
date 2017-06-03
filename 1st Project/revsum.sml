

val infile = "/Users/konstantinos/Desktop/untitled folder/input.txt";


(*val args = CommandLine.arguments()*)
(*fun sum l = foldr op+ 0 (map (valOf o Int.fromString) l)*)
(*val filename = hd(CommandLine.arguments());*)
(*print(explode(CommandLine.arguments()));*)


fun string(NONE) = ""
  | string(SOME a) = a;



(*print(string(TextIO.inputLine(input)));*)



fun nth(xs, i) = 						(*find nth of list*)
	if i < 0
	then raise Subscript
	else
		case xs of
			[] => raise Subscript
		| (x::xs') => if i=0 then x else nth(xs',i-1);

fun CheckN list N =					(*returns Nth char of string*)
	let
		val char = nth(list, N);
		val int = ord char;
	
	in 	int
	end; 

fun CheckN2 list N =					(*returns Nth char of string*)
	let
		val char = nth(list, N);
		val int = ord char;
		val int = int-48;
	
	in 	int
	end; 

val temp = 0;

fun OddAce (InHead, OutHead, OutTail, crr:int, previoussituation:int, endd:int, i, len) =
	if (i = len div 2) then (OutHead, OutTail)
	(*Situation 1*)
	else if (CheckN InHead (i+1) = CheckN InHead (len-1-i)) then
			if (previoussituation = 0) then 
				if (CheckN InHead (i+1) = 57 andalso CheckN InHead (len-i-1) = 57) then (OutHead, OutTail)
				else
				let
					val OutHead = (#"9" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp+1;
					val temp = chr temp;
					val OutTail = if (CheckN InHead (len-1-i) = 57) then
									(#"0" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					
				in OddAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
			end
			else if (previoussituation = 1) then 
				if (crr = 0) then
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp - 1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else 
					let
						 val temp = CheckN InHead (len-1-i);
						 val temp = chr temp;
						 val OutHead = (temp :: []) @ OutHead;
						 val OutTail = (#"9" :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else if (previoussituation = 2) then 
				if (crr = 0) then
					let
						val temp = CheckN InHead (len-1-i);
						val temp = temp + 1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-2-i) = 57) then 
										(#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
				else
					let
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = (#"0" :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else 
				if (crr = 0) then 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end


	(*Situation 2*)
	else if ((CheckN InHead (i+1) = (CheckN InHead (len-1-i)+1)) orelse ((CheckN InHead (i+1) = 48) andalso (CheckN InHead (len-1-i) = 57))) then
			if (previoussituation = 0) then	
				let
					val OutHead = (#"9" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp + 1;
					val temp = chr temp;
					val OutTail = if (temp = #":") then
									(#"0" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					
				in OddAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
			end
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = (#"9" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp+1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 57) then
									(#"0" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp - 1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
			else if (previoussituation = 2) then
				if (crr = 0) then
					if (CheckN InHead (len-1-i) = 57) then
						let
							val OutHead = (#"0" :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in OddAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp + 1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in OddAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
					end
				else
					if (CheckN InHead (len-i) = 57) then
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp+1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in OddAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = chr temp;
							val OutHead = (temp :: []) @ OutHead;
							val OutTail = (#"0" :: []) @ OutTail;
						in OddAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
			else 
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp-1;
					val temp = chr temp;
					val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
				in OddAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
	(*Situation 3*)
	else if ((CheckN InHead (i+1) = (CheckN InHead (len-1-i)-1)) orelse ((CheckN InHead (i+1) = 57) andalso (CheckN InHead (len-1-i) = 48))) then
			if (previoussituation = 0) then (OutHead, OutTail)
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = temp+1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-i) = 57) then (#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
			else if (previoussituation = 2)  then
				let
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutHead = (temp :: []) @ OutHead;
					val OutTail = (#"9" :: []) @ OutTail;
				in OddAce (InHead, OutHead, OutTail, 1, 3, endd, i+1, len)
			end
			else 
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in OddAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
	else ([], []);

fun EvenAce (InHead, OutHead, OutTail, crr:int, previoussituation:int, endd:int, i, len) =
	
	if (i = ((len-1) div 2)) then (OutHead, OutTail)
	
	

	(*Situation 1*)
	else if (CheckN InHead (i+1) = CheckN InHead (len-1-i)) then
			if (previoussituation = 0) then 
				if (CheckN InHead (i+1) = 57 andalso CheckN InHead (len-i-1) = 48) then (OutHead, OutTail)
				else
				let
					val OutHead = (#"9" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp+1;
					val temp = chr temp;
					val OutTail = if (CheckN InHead (len-1-i) = 57) then
									(#"0" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					
				in EvenAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
			end
			else if (previoussituation = 1) then 
				if (crr = 0) then
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else 
					let
						 val temp = CheckN InHead (len-1-i);
						 val temp = chr temp;
						 val OutHead = (temp :: []) @ OutHead;
						 val OutTail = (#"9" :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else if (previoussituation = 2) then 
				if (crr = 0) then
					let
						val temp = CheckN InHead (len-1-i);
						val temp = temp + 1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-2-i) = 57) then 
										(#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
				else
					let
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else 
				if (crr = 0) then 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end


	(*Situation 2*)
	else if ((CheckN InHead (i+1) = (CheckN InHead (len-1-i)+1)) orelse ((CheckN InHead (i+1) = 48) andalso (CheckN InHead (len-1-i) = 57))) then
			if (previoussituation = 0) then	
				let
					val OutHead = (#"9" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp + 1;
					val temp = chr temp;
					val OutTail = if (temp = #":") then
									(#"0" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					
				in EvenAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp - 1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
			else if (previoussituation = 2) then
				if (crr = 0) then
					if (CheckN InHead (len-1-i) = 57) then
						let
							val OutHead = (#"0" :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in EvenAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp + 1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in EvenAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
				else
					if (CheckN InHead (len-i) = 57) then
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp+1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in EvenAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = chr temp;
							val OutHead = (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in EvenAce (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
			else 
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp-1;
					val temp = chr temp;
					val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
				in EvenAce (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
	(*Situation 3*)
	else if ((CheckN InHead (i+1) = (CheckN InHead (len-1-i)-1)) orelse ((CheckN InHead (i+1) = 57) andalso (CheckN InHead (len-1-i) = 48))) then
			if (previoussituation = 0) then (OutHead, OutTail)
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = temp+1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-i) = 57) then (#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
			else if (previoussituation = 2)  then
				let
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutHead = (temp :: []) @ OutHead;
					val OutTail = (#"9" :: []) @ OutTail;
				in EvenAce (InHead, OutHead, OutTail, 1, 3, endd, i+1, len)
			end
			else 
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in EvenAce (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
	else ([], []);


fun Even (InHead, OutHead, OutTail, crr:int, previoussituation:int, endd:int, i, len) =
	if (i = len div 2) then (OutHead, OutTail)
	(*Situation 1*)
	else if (CheckN InHead (i) = CheckN InHead (len-1-i)) then
			if (previoussituation = 0) then 
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutTail = (temp :: []) @ OutTail;
				in Even (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
			end
			else if (previoussituation = 1) then 
				if (crr = 0) then
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else 
					let
						 val temp = CheckN InHead (len-1-i);
						 val temp = chr temp;
						 val OutHead = (temp :: []) @ OutHead;
						 val OutTail = (#"9" :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else if (previoussituation = 2) then 
				if (crr = 0) then
					let
						val temp = CheckN InHead (len-1-i);
						val temp = temp + 1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-2-i) = 57) then 
										(#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
				else
					let
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else 
				if (crr = 0) then 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end


	(*Situation 2*)
	else if ((CheckN InHead (i) = (CheckN InHead (len-1-i)+1)) orelse ((CheckN InHead (i) = 48) andalso (CheckN InHead (len-1-i) = 57))) then
			if (previoussituation = 0) then	
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutTail = (temp :: []) @ OutTail;
					
				in Even (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp - 1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
			else if (previoussituation = 2) then
				if (crr = 0) then
					if (CheckN InHead (len-1-i) = 57) then
						let
							val OutHead = (#"0" :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Even (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp+1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Even (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
				else
					if (CheckN InHead (len-i) = 57) then
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp+1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Even (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = chr temp;
							val OutHead = (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Even (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
			else 
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp-1;
					val temp = chr temp;
					val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
				in Even (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
	(*Situation 3*)
	else if ((CheckN InHead (i) = (CheckN InHead (len-1-i)-1)) orelse ((CheckN InHead (i) = 57) andalso (CheckN InHead (len-1-i) = 48))) then
			if (previoussituation = 0) then (OutHead, OutTail)
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = temp+1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-i) = 57) then (#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
			else if (previoussituation = 2)  then
				let
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutHead = (temp :: []) @ OutHead;
					val OutTail = (#"9" :: []) @ OutTail;
				in Even (InHead, OutHead, OutTail, 1, 3, endd, i+1, len)
			end
			else 
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Even (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
	else ([], []);

fun Odd (InHead, OutHead, OutTail, crr:int, previoussituation:int, endd:int, i, len) =
	
	if (i = ((len-1) div 2)) then (OutHead, OutTail)
	
	

	(*Situation 1*)
	else if (CheckN InHead (i) = CheckN InHead (len-1-i)) then
			if (previoussituation = 0) then 
				if (CheckN InHead (i) = 57 andalso CheckN InHead (len-i-1) = 48) then ([], [])
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					
					in  Odd (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
			else if (previoussituation = 1) then 
				if (crr = 0) then
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else 
					let
						 val temp = CheckN InHead (len-1-i);
						 val temp = chr temp;
						 val OutHead = (temp :: []) @ OutHead;
						 val OutTail = (#"0" :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else if (previoussituation = 2) then 
				if (crr = 0) then
					let
						val temp = CheckN InHead (len-1-i);
						val temp = temp + 1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-2-i) = 57) then 
										(#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
				else
					let
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = (#"9" :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 1, 1, endd, i+1, len)
				end
			else 
				if (crr = 0) then 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 1, endd, i+1, len)
				end


	(*Situation 2*)
	else if ((CheckN InHead (i) = (CheckN InHead (len-1-i)+1)) orelse ((CheckN InHead (i) = 48) andalso (CheckN InHead (len-1-i) = 57))) then
			if (previoussituation = 0) then	
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutTail = (temp :: []) @ OutTail;
				in Odd (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = chr temp;
						val OutTail = (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
				else
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp - 1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then
									(#"9" :: []) @ OutTail					
								else (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
				end
			else if (previoussituation = 2) then
				if (crr = 0) then
					if (CheckN InHead (len-1-i) = 57) then
						let
							val OutHead = (#"0" :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Odd (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp + 1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Odd (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
				else
					if (CheckN InHead (len-i) = 57) then
						let
							val temp = CheckN InHead (len-1-i);
							val temp = temp+1;
							val temp = chr temp;
							val OutHead = if (CheckN InHead (len-1-i) = 57) then (#"0" :: []) @ OutHead
										else (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Odd (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
					else
						let
							val temp = CheckN InHead (len-1-i);
							val temp = chr temp;
							val OutHead = (temp :: []) @ OutHead;
							val OutTail = (#"9" :: []) @ OutTail;
						in Odd (InHead, OutHead, OutTail, 1, 2, endd, i+1, len)
					end
			else 
				let
					val OutHead = (#"0" :: []) @ OutHead;
					val temp = CheckN InHead (len-1-i);
					val temp = temp-1;
					val temp = chr temp;
					val OutTail = (temp :: []) @ OutTail;
				in Odd (InHead, OutHead, OutTail, 0, 2, endd, i+1, len)
			end
	(*Situation 3*)
	else if ((CheckN InHead (i) = (CheckN InHead (len-1-i)-1)) orelse ((CheckN InHead (i) = 57) andalso (CheckN InHead (len-1-i) = 48))) then
			if (previoussituation = 0) then ([], [])
			else if (previoussituation = 1) then
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = temp+1;
						val temp = chr temp;
						val OutHead = if (CheckN InHead (len-i) = 57) then (#"0" :: []) @ OutHead
									else (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
			else if (previoussituation = 2)  then
				let
					val temp = CheckN InHead (len-1-i);
					val temp = chr temp;
					val OutHead = (temp :: []) @ OutHead;
					val OutTail = (#"9" :: []) @ OutTail;
				in Odd (InHead, OutHead, OutTail, 1, 3, endd, i+1, len)
			end
			else 
				if (crr = 0) then
					let
						val OutHead = tl OutHead;
						val temp = CheckN InHead (len-i);
						val temp = chr temp;
						val OutHead = (temp :: []) @ OutHead;
						val OutTail = tl OutTail;
						val OutTail = (#"9" :: []) @ OutTail;

						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
				else 
					let 
						val OutHead = (#"0" :: []) @ OutHead;
						val temp = CheckN InHead (len-1-i);
						val temp = temp-1;
						val temp = chr temp;
						val OutTail = if (CheckN InHead (len-1-i) = 48) then (#"9" :: []) @ OutTail
									else (temp :: []) @ OutTail;
					in Odd (InHead, OutHead, OutTail, 0, 3, endd, i+1, len)
				end
	else ([], []);


fun checkOddAce (OutHead, InHead, crr, 1, i, len) = (1, ~1)
| checkOddAce (OutHead, InHead, crr, endd, i, len) = 
	if ((len mod 2) = 1 andalso (i = len-1) andalso (crr = 1)) then (1, 100)
	else if ((len mod 2) = 1 andalso (i = len-1)) then (1, ~1)
	else if (((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-2))+crr) mod 10)) = CheckN2 InHead (len-i-1)) andalso (CheckN2 OutHead (i)+crr+(CheckN2 OutHead (len-i-2)))<10) then
		checkOddAce (OutHead, InHead, 0, 0, i+1, len)
	else if ((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-2))+crr) mod 10)) = CheckN2 InHead (len-i-1)) then
		checkOddAce (OutHead, InHead, 1, 0, i+1, len)
	else checkOddAce (OutHead, InHead, crr, 1, i+1, len);

fun checkEvenAce (OutHead, InHead, crr, 1, i, len) = (1, ~1)
| checkEvenAce (OutHead, InHead, crr, endd, i, len) = 
	if ((len mod 2) = 0 andalso (i = len-1) andalso (crr = 1)) then (1, 100)
	else if ((len mod 2) = 0 andalso (i = len-1)) then (1, ~1)
	else if (((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-2))+crr) mod 10)) = CheckN2 InHead (len-i-1)) andalso (CheckN2 OutHead (i)+crr+(CheckN2 OutHead (len-i-2)))<10) then
		checkEvenAce (OutHead, InHead, 0, 0, i+1, len)
	else if ((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-2))+crr) mod 10)) = CheckN2 InHead (len-i-1)) then
		checkEvenAce (OutHead, InHead, 1, 0, i+1, len)
	else checkEvenAce (OutHead, InHead, crr, 1, i+1, len);


fun checkEven (OutHead, InHead, crr, 1, i, len) = (0, ~1)
| checkEven (OutHead, InHead, crr, endd, i, len) = 
	if ((len mod 2) = 0 andalso (i = len)) then (0, 100)
	else if (((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-1))+crr) mod 10)) = CheckN2 InHead (len-i-1)) andalso (CheckN2 OutHead (i)+crr+(CheckN2 OutHead (len-i-1)))<10) then
		checkEven (OutHead, InHead, 0, 0, i+1, len)
	else if ((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-1))+crr) mod 10)) = CheckN2 InHead (len-i-1)) then
		checkEven (OutHead, InHead, 1, 0, i+1, len)
	else checkEven (OutHead, InHead, crr, 1, i+1, len);


fun checkOdd (OutHead, InHead, crr, 1, i, len) = (0, ~1)
| checkOdd (OutHead, InHead, crr, endd, i, len) = 
	if ((len mod 2) = 1 andalso (i = len)) then (0, 100)
	else if (((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-1))+crr) mod 10)) = CheckN2 InHead (len-i-1)) andalso (CheckN2 OutHead (i)+crr+(CheckN2 OutHead (len-i-1)))<10) then
		checkOdd (OutHead, InHead, 0, 0, i+1, len)
	else if ((((CheckN2 OutHead (i)+(CheckN2 OutHead (len-i-1))+crr) mod 10)) = CheckN2 InHead (len-i-1)) then
		checkOdd (OutHead, InHead, 1, 0, i+1, len)
	else checkOdd (OutHead, InHead, crr, 1, i+1, len);


 (*909313
   313909
  1223222*)



fun revsum infile  = 
		let
 			val input = "string(TextIO.inputLine(TextIO.openIn(infile)));"
 			val InHead = explode(string(TextIO.inputLine(TextIO.openIn(infile))));
			val OutHead = [];
			val OutTail = [];
			val i = 0;
			val len = size(input)-1;
			val previoussituation = 0;
			val crr = 1;
			val endd = 0;


			val (OutHead, OutTail) = if (len mod 2 = 1 andalso not (CheckN InHead 0 = 49)) then				(*Odd*)
				let
					val (a, b) = Odd (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len)
					val (a, b) = if ((a, b) = ([], []) andalso not (len = 1)) then (a, b)
							else if ((0, 100) = checkOdd ((rev(b)@ [chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a), InHead, 0, 0, 0, len)) then
								([chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((CheckN InHead (len div 2))-1)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+9) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, b)
							else ([], []);
				in (a, b)
			end
			else if (len mod 2 = 0 andalso not (CheckN InHead 0 = 49)) then									(*Even*)
				let
					val (t1, t2) = Even (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len);
					val (a, b) = if ((t1, t2) = ([], [])) then (t1, t2)
							else if ((0, 100) = checkEven (rev (t2) @ t1, InHead, 0, 0, 0, len)) then
								(t2, t1)
							else ([], []);
				in (a, b)
			end
			else if (len mod 2 = 0) then 																	(*EvenAce*)
				let
					val (t1, t2) = Even (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len);
					val (a, b) = EvenAce (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len);
					val (a, b) = if ((a, b) = ([], []) andalso not(len = 2)) then (a, b)
							else if ((1, 100) = checkEvenAce ((rev(b)@ [chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a), InHead, 0, 0, 0, len)) then
								([chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a, b)
							else if ((1, 100) = checkEvenAce (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, b)
							else if ((1, 100) = checkEvenAce (rev(b)@ [chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((CheckN InHead (len div 2))-1)] @ a, b)
							else if ((1, 100) = checkEvenAce (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+9) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, b)
							else ([], []);

					val (t1, t2) = if ((t1, t2) = ([], [])) then (t1, t2)
							else if ((0, 100) = checkEven (rev(t2) @ t1, InHead, 0, 0, 0, len)) then
								(t1, t2)
							else ([], []);

					val (a, b) = if ((t1, t2) = ([], []) andalso not ((a, b) = ([], []))) then (a, b)
							else (t1, t2);

				in (a, b)
			end
			else 																							(*OddAce*)
				let
					val (t1, t2) = OddAce (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len);
					val (a, b) = Odd (InHead, OutHead, OutTail, crr, previoussituation, endd, 0, len);
					val (a, b) = if ((a, b) = ([], [])) then (a, b)
							else if ((0, 100) = checkOdd ((rev(b)@ [chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a), InHead, 0, 0, 0, len)) then
								([chr (((CheckN2 InHead (len div 2)) div 2)+48)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2))+10) div 2)+48)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((CheckN InHead (len div 2))-1)] @ a, b)
							else if ((0, 100) = checkOdd (rev(b)@ [chr ((((CheckN2 InHead (len div 2))+9) div 2)+48)] @ a, InHead, 0, 0, 0, len)) then
								([chr ((((CheckN2 InHead (len div 2) -1)) div 2)+48)] @ a, b)
							else ([], []);

					val (t1, t2) = if ((t1, t2) = ([], [])) then (t1, t2)
							else if ((1, 100) = checkOddAce (rev(t2) @ t1, InHead, 0, 0, 0, len)) then
								(t1, t2)
							else ([], [])


					val (a, b) = if ((t1, t2) = ([], []) andalso not ((a, b) = ([], []))) then (a, b)
							else (t1, t2);

				in (a, b)
			end
			
			
			
			val output = if ((OutHead, OutTail) = ([], [])) then "0"
					else if (not (OutTail = []) andalso not (CheckN2 (rev(OutTail)) (0) = 0)) then implode ((rev(OutTail)) @ OutHead)
					else implode (rev((rev(OutTail)) @ OutHead))

		in output
			
	end;









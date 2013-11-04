exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(* end helper code *)


(* problem 1 *)
val only_capitals = List.filter(fn s => Char.isUpper(String.sub(s, 0)))


(* problem 2 *)
val longest_string1 = List.foldl(fn (s, n) => if (String.size(s) > String.size(n)) then s else n) "" 
     

(* problem 3 *)
val longest_string2 = List.foldl(fn (s, n) => if (String.size(s) >= String.size(n)) then s else n) "" 


(* problem 4 *)
fun longest_string_helper f strlist =
    List.foldl(fn (s, n) => if f(String.size(s), String.size(n)) then s else n) "" strlist

val longest_string3 = longest_string_helper (fn (s, n) => s > n)

val longest_string4 = longest_string_helper (fn (s, n) => s >= n)


(* problem 5 *)
val longest_capitalized = longest_string1 o only_capitals


(* problem 6 *)
val rev_string = String.implode o List.rev o String.explode


(* problem 7 *)
fun first_answer f lst = 
    let val temp = List.map f lst
    in case temp of
	   [] => raise NoAnswer
	 | SOME x :: _ => x
	 | NONE :: _ => first_answer f (tl lst)
    end 


(* problem 8 *)
fun all_answers f lst = 
    let fun helper lt acc = 
	    case lt of
		[] => SOME(acc)
	      | SOME x :: xs => helper xs (acc @ x)
	      | NONE :: _ => NONE
    in helper (List.map f lst) []
    end


(* problem 9a *)
val count_wildcards = g (fn z => 1) (fn x => 0) 

(* problem 9b *)
val count_wild_and_variable_lengths = g (fn z => 1) (fn x => String.size(x))

(* problem 9c *)
fun count_some_var (str, pat) =
    g (fn z => 0) (fn x => if x = str then 1 else 0) pat


(* problem 10 *)
fun check_pat pat = 
    let fun listgen p =
	case p of
	    Wildcard => []
	  | Variable x => [x]
 	  | TupleP ps => List.foldl (fn (p,i) => (listgen p) @ i) [] ps
	  | ConstructorP(_,p) => listgen p
	  | _ => []
	
	fun numcheck ls =
	    case ls of
		[] => true
	      | x :: xs => if List.exists (fn z => z = x) (xs) then false else numcheck xs
    in numcheck (listgen pat)
    end


(* problem 11 *)
fun match(value, patrn) = 
    let exception NoMatch
	fun listgen (v, p) = 
	    case (v, p) of
		(_, Wildcard) => []
	      | (Unit, UnitP) => []
	      | (Const x, ConstP y) => if x = y then [] else raise NoMatch
	      | (any, Variable s) => [(s, any)]
	      | (Tuple ts, TupleP us) => if length(ts) = length(us) then List.foldl (fn (a, b) => b @ (listgen a)) [] (ListPair.zip(ts, us)) else raise NoMatch
	      | (Constructor(n1, j), ConstructorP(n2, k)) => if n1 = n2 then listgen(j, k) else raise NoMatch
	      | _ => raise NoMatch
    in SOME (listgen(value, patrn)) handle NoMatch => NONE
    end 


(* problem 12 *)
fun first_match v patlist = 
    SOME (first_answer match (List.map (fn x => (v, x)) patlist)) handle NoAnswer => NONE


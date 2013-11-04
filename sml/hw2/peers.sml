(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
(* aux functions *)
fun rev(xs) =
  let fun aux(ys, acc) =
    case ys of
         []     => acc
       | y::ys' => aux(ys', y::acc)
  in aux(xs, []) end

(* 1.a *)
fun all_except_option (str, xs) =
  let fun aux(xs, ys) =
        case xs of
             []     => NONE
           | x::xs' => if same_string(str, x)
                       then SOME (ys @ xs')
                       else aux(xs', ys @ [x])
  in aux(xs, []) end

(* 1.b *)
fun get_substitutions1 (xss, str) =
  case xss of
       []       => []
     | xs::xss' => case all_except_option(str, xs) of
                        NONE     => get_substitutions1(xss', str)
                      | SOME xs' => xs' @ get_substitutions1(xss', str)

(* 1.c *)
fun get_substitutions2 (yss, str) =
  let fun aux(xss, acc) =
    case xss of
         []       => acc
       | xs::xss' => case all_except_option(str, xs) of
                          NONE     => aux(xss', acc)
                        | SOME xs' => aux(xss', acc @ xs')
  in aux(yss, []) end

(* 1.d *)
fun similar_names(xss, full_name) =
  let
    val {first=f, middle=m, last=l} = full_name
    fun other_names(xs, acc) =
      case xs of
           []     => acc
         | x::xs' => other_names(xs', {first=x, middle=m, last=l}::acc)
  in rev(other_names(get_substitutions1(xss, f), [full_name])) end


(* you may assume that Num is always used with values 2, 3, ..., 9
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)
(* 2.a *)
fun card_color c =
  case c of
       (Spades,_) => Black
     | (Clubs,_)  => Black
     | _          => Red

(* 2.b *)
fun card_value c =
  case c of
       (_, Num v) => v
     | (_, Ace)   => 11
     | _          => 10

(* 2.c *)
fun remove_card (cs, c, ex) =
  let fun aux(xs, acc) =
    case xs of
         []     => raise ex
       | x::xs' => if c = x
                   then rev(acc) @ xs'
                   else aux(xs', x::acc)
  in aux(cs, []) end

(* 2.d *)
fun all_same_color cards =
  case cards of
       c1::c2::cs => (card_color c1 = card_color c2) andalso all_same_color(c2::cs)
     | _          => true

(* 2.e *)
fun sum_cards cards =
  let fun sum(xs, acc) =
        case xs of
             []     => acc
           | x::xs' => sum(xs', (card_value x) + acc)
  in sum(cards, 0) end

(* 2.f *)
fun score(cards, goal) =
  let
    val sum = sum_cards cards
    val pscore = if sum > goal
                   then 3 * (sum - goal)
                   else goal - sum
  in
    if all_same_color cards
    then pscore div 2
    else pscore
  end

(* 2.g *)
fun officiate (card_deck, moves, goal) =
  let fun play(cs, ms, hcs) =
        case ms of
             []               => score(hcs, goal) (* no more move *)
           | (Discard c)::ms' => play(cs, ms', remove_card(hcs, c, IllegalMove))
           | Draw::ms'        => case cs of
                                      []     => score(hcs, goal) (* card is empty *)
                                    | c::cs' => let
                                                  val hcs' = c::hcs
                                                in
                                                  if (sum_cards hcs') > goal
                                                  then score(hcs', goal)
                                                  else play(cs', ms', hcs')
                                                end

  in play(card_deck, moves, []) end

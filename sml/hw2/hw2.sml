(* problem 1 helper code *)
fun same_string (s1 : string, s2 : string) =
    s1 = s2

(* PROBLEM 1 START *)
(* problem 1a *)
fun all_except_option (str , lst) = 
    let fun lister (string_check, lst_check) =
	    case lst_check of
		[] => []
	      | beg :: fin => if same_string(beg, string_check)
			      then fin
			      else beg :: lister(string_check, fin)
    in 
	case lst of
	    [] => NONE 
	  | _ => SOME (lister(str, lst))
    end 

(* problem 1b *)
fun get_substitutions1 (listosubs, str) = 
    case listosubs of
	[] => []
      | lst1 :: others => let val check = all_except_option(str, lst1)
			      val more = get_substitutions1(others, str)
			  in if SOME lst1 = check
			     then more
			     else case check of
				      SOME result => result @ more
				    | NONE  => []
			  end 

(* problem 1c *)
fun get_substitutions2 (listosubs, str) =
    let fun subber (sub_list, s, result) =
	    case sub_list of 
		[] => result
	      | head :: tail => let val check = all_except_option(s, head)
				in if check = SOME head
				   then subber(tail, s, result)
				   else case check of 
					    SOME lst => subber(tail, s, (result @ lst))
					  | NONE => subber(tail, s, result)
				end 
    in subber(listosubs, str, [])
    end 

(* problem 1d *)
fun similar_names (listosubs, {first = f, middle = m, last = l}) =
    let val name_list = get_substitutions1(listosubs, f)
	fun name_cycle (names, result) = 
	    case names of
		[] => [{first = f, middle = m, last = l}] @ result
	      | name1 :: others => name_cycle(others, result @ [{first = name1, middle = m, last = l}])
    in name_cycle(name_list, [])
    end
    
(* PROBLEM 1 END *)

				

(* problem 2 helper code *)
(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* PROBLEM 2 START *)
(* problem 2a *)
fun card_color (suit, rank) = 
    case suit of
	Clubs => Black
      | Spades => Black 
      | _ => Red

(* problem 2b *)
fun card_value ((suit, rank) : card) =
    case rank of
	Num x => x
      | Ace => 11
      | _ => 10
	
(* problem 2c *)
fun remove_card (cs, c, e) = 
    case cs of 
	[] => raise e
      | head :: tail => if head = c
			then tail
			else head :: remove_card(tail, c, e)

(* problem 2d *)
fun all_same_color (card_list) =
    case card_list of
	[] => true
      | card :: others => let val color = card_color(card)
			  in case others of
				 [] => true
			       | first :: rest => color = card_color(first) andalso all_same_color(rest) 
			  end

(* problem 2e *)
fun sum_cards (card_list) = 
    case card_list of
	[] => 0
      | some :: more => let fun summer (cards, acc) =
				case cards of
				    [] => acc
				  | first :: others => summer(others, acc + card_value(first))
			in summer(card_list, 0)
			end

(* problem 2f *)
fun score (held_cards, goal) = 
    let val points = sum_cards(held_cards)
	val same = all_same_color(held_cards)
	fun pointer (p, g) =
	    if p >= g
	    then (p - g) * 3
	    else (g - p)
    in if same
       then pointer(points, goal) div 2
       else pointer(points, goal)
    end 

(* problem 2g *)
fun officiate (card_list, move_list, target_goal) =  
    let fun gamestate (deck, moves, goal, hand) = 
	    if sum_cards(hand) > goal
	    then score(hand, goal) 
	    else case moves of 
		     [] => score(hand, goal)
		   | m1 :: rest_of_moves => case m1 of 
						Discard c => gamestate(deck, rest_of_moves, goal, remove_card(hand, c, IllegalMove))
					     |  Draw => case deck of
							    [] => score(hand, goal)
							  | next :: rest_of_deck => gamestate(rest_of_deck, rest_of_moves, goal, next :: hand)
    in gamestate(card_list, move_list, target_goal, [])
    end

(* PROBLEM 2 END *)


(* PROBLEM 3 START *)
(* problem 3a *)
(* not implemented *)
fun score_challenge (held_cards, goal) =
    score(held_cards, goal)

fun officiate_challenge (card_list, move_list, target_goal) =  
    let fun gamestate (deck, moves, goal, hand) = 
	    if sum_cards(hand) > goal
	    then score(hand, goal) 
	    else case moves of 
		     [] => score(hand, goal)
		   | m1 :: rest_of_moves => case m1 of 
						Discard c => gamestate(deck, rest_of_moves, goal, remove_card(hand, c, IllegalMove))
					     |  Draw => case deck of
							    [] => score(hand, goal)
							  | next :: rest_of_deck => gamestate(rest_of_deck, rest_of_moves, goal, next :: hand)
    in gamestate(card_list, move_list, target_goal, [])
    end


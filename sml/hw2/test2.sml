(* problem 1 variables *)
val s1 = "hello"
val s2 = "nope"
val s3 = "Fred"
val s4 = "Jeff"
val ls0 = []
val ls1 = ["there", "hello", "you"]
val lls1 = [["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]]
val lls2 = [["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]]
val n1 = {first="Fred", middle="W", last="Smith"}

(* problem 2 variables *)
exception Tester
val c1 = (Clubs, Num(9))
val c2 = (Hearts, Queen)
val c3 = (Spades, Ace)
val c4 = (Diamonds, Num(2))
val c5 = (Diamonds, King)
val cl1 = [c1, c2, c3, c4]
val cl2 = [c2, c4, c5]
val ct1 = [(Clubs,Jack),(Spades,Num(8))]
val ct2 = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
val ct3 = [(Spades, Ace), (Spades, Num(9)), (Spades, Queen), (Spades, King), (Spades, Jack)]
val ml1 = [Draw,Discard(Hearts,Jack)]
val ml2 = [Draw,Draw,Draw,Draw,Draw]
val ml3 = [Draw,Draw,Draw,Draw,Draw, Discard(Spades, Ace)]
val ml4 = [Draw,Draw,Draw,Draw, Discard(Spades, Ace)]



(* problem 1 testing *)
val test1a_0 = all_except_option(s1, ls1) = SOME ["there", "you"]
val test1a_1 = all_except_option(s2, ls1) = NONE
val test1a_2 = all_except_option(s1, ls0) = NONE

val test1b_0 = get_substitutions1(lls1, s3) = ["Fredrick","Freddie","F"]
val test1b_1 = get_substitutions1(lls2, s4) = ["Jeffrey","Geoff","Jeffrey"]
val test1b_2 = get_substitutions1(lls2, s2) = []
val test1b_3 = get_substitutions1(ls0, s4) = []

val test1c_0 = get_substitutions2(lls1, s3) = ["Fredrick","Freddie","F"]
val test1c_1 = get_substitutions2(lls2, s4) = ["Jeffrey","Geoff","Jeffrey"]
val test1c_2 = get_substitutions2(lls2, s2) = []
val test1c_3 = get_substitutions2(ls0, s4) = []

val test1d_0 = similar_names(lls1, n1) = [{first="Fred", last="Smith", middle="W"},
					  {first="Fredrick", last="Smith", middle="W"},
					  {first="Freddie", last="Smith", middle="W"},
					  {first="F", last="Smith", middle="W"}]
val test1d_1 = similar_names(ls0, n1) = [n1]





(* problem 2 testing *)
val test2a_0 = card_color(c1) = Black
val test2a_1 = card_color(c2) = Red

val test2b_0 = card_value(c1) = 9
val test2b_1 = card_value(c2) = 10
val test2b_2 = card_value(c3) = 11
val test2b_3 = card_value(c4) = 2

val test2c_0 = remove_card(cl1, c1, Tester) = [c2, c3, c4]
val test2c_1 = remove_card(cl1, c3, Tester) = [c1, c2, c4]
val test2c_2 = remove_card(cl1, c4, Tester) = [c1, c2, c3]
(* remove_card(cl1, c5, Tester) *)

val test2d_0 = all_same_color(cl1) = false
val test2d_1 = all_same_color([c1, c3]) = true
val test2d_2 = all_same_color([c2, c4, c5, c1]) = false
	       
val test2e_0 = sum_cards(cl1) = 32
val test2e_1 = sum_cards([c1]) = 9
val test2e_2 = sum_cards([]) = 0

val test2f_0 = score(cl1, 32) = 0
val test2f_1 = score(cl1, 28) = 12
val test2f_2 = score(cl1, 35) = 3
val test2f_3 = score(cl2, 22) = 0
val test2f_4 = score(cl2, 18) = 6
val test2f_5 = score(cl2, 25) = 1

val test2g_0 = officiate(ct2, ml2, 42) = 3
val test2g_1 = officiate(ct2, [], 0) = 0
val test2g_2 = officiate([], ml2, 0) = 0
val test2g_3 = officiate(cl1, ml2, 28) = 6
val test2g_4 = officiate(ct2, ml3, 42) = 3
val test2g_5 = officiate(ct3, ml2, 43) = 10
val test2g_6 = officiate(ct3, ml3, 50) = 5
val test2g_7 = officiate(ct2, ml4, 44) = 5
(* officiate(ct1, ml1, 42) *)


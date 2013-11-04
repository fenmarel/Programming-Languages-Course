val sl1 = ["Hello", "World", "How", "do", "You", "Do"]
val sl2 = ["hello", "World", "how", "do", "You", "Do"]
val sl3 = ["hello", "world", "how", "do", "you", "do"]
val sl4 = ["hello", "world", "how", "do", "you", "do", "zaboomafoo"]
val sl5 = ["Hello", "World", "How", "do", "You", "There", "Do"]
val sl6 = ["Hello", "World", "How", "do", "You", "Dooodle"]

fun is_even x =
    if x mod 2 = 0 then SOME[(x)] else NONE

fun is_even2 x =
    if x mod 2 = 0 then SOME (x) else NONE

val l1 = [1, 2, 3, 4, 5]
val l2 = [2, 4, 6, 8, 10]
val l3 = [1, 3, 5, 7, 9]





val test1_1 = only_capitals(sl1) = ["Hello", "World", "How", "You", "Do"]
val test1_2 = only_capitals(sl2) = ["World", "You", "Do"]
val test1_3 = only_capitals(sl3) = []

val test2_1 = longest_string1(sl1) = "Hello"
val test2_2 = longest_string1(sl4) = "zaboomafoo"
val test2_3 = longest_string1([]) = ""

val test3_1 = longest_string2(sl5) = "There"
val test3_2 = longest_string2(sl4) = "zaboomafoo"
val test3_3 = longest_string2([]) = ""

val test4a_1 = longest_string1(sl1) = "Hello"
val test4a_2 = longest_string1(sl4) = "zaboomafoo"
val test4a_3 = longest_string1([]) = ""

val test4b_1 = longest_string2(sl5) = "There"
val test4b_2 = longest_string2(sl4) = "zaboomafoo"
val test4b_3 = longest_string2([]) = ""

val test5_1 = longest_capitalized(sl1) = "Hello"
val test5_2 = longest_capitalized(sl2) = "World"
val test5_3 = longest_capitalized(sl6) = "Dooodle"
val test5_4 = longest_capitalized([]) = ""

val test6_1 = rev_string("hello") = "olleh"
val test6_2 = rev_string("GoodBye") = "eyBdooG"
val test6_3 = rev_string("") = ""

val test7_1 = first_answer is_even2 l1 = 2
val test7_2 = first_answer is_even2 l2 = 2
val test7_3 = (first_answer is_even2 l3 handle NoAnswer => 0) = 0
val test7_4 = (first_answer is_even2 [] handle NoAnswer => 0) = 0

val test8_1 = all_answers is_even l1 = NONE
val test8_2 = all_answers is_even l2 = SOME [2, 4, 6, 8, 10]
val test8_3 = all_answers is_even l3 = NONE
val test8_4 = all_answers is_even [] = SOME []

val test9a_1 = count_wildcards(TupleP([Wildcard, ConstructorP("a", Wildcard), Variable("z"), Wildcard])) = 3
val test9a_2 = count_wildcards(TupleP([ConstructorP("a", Wildcard), Variable("z"), Wildcard])) = 2
val test9a_3 = count_wildcards(TupleP([Wildcard])) = 1
val test9a_4 = count_wildcards(TupleP([ConstructorP("a", Variable("hi")), Variable("z")])) = 0

val test9b_1 = count_wild_and_variable_lengths(TupleP([Wildcard, ConstructorP("a", Wildcard), Variable("zd"), Wildcard])) = 5
val test9b_2 = count_wild_and_variable_lengths(TupleP([Wildcard, ConstructorP("a", Wildcard), Variable("zaboomafoo"), Wildcard, Variable("yep")])) = 16
val test9b_3 = count_wild_and_variable_lengths(TupleP([Wildcard, ConstructorP("a", Wildcard), Wildcard])) = 3
val test9b_4 = count_wild_and_variable_lengths(TupleP([Variable("abc")])) = 3 
val test9b_5 = count_wild_and_variable_lengths(TupleP([Wildcard])) = 1
val test9b_6 = count_wild_and_variable_lengths(TupleP([])) = 0

val test9c_1 = count_some_var ("abc", (TupleP([Wildcard, ConstructorP("abc", Wildcard), Variable("abc"), Wildcard, Variable("xyz"), Variable("abc")]))) = 2
val test9c_2 = count_some_var ("abc", (TupleP([Wildcard, ConstructorP("abc", Wildcard), Variable("abc"), Wildcard, Variable("xyz")]))) = 1
val test9c_3 = count_some_var ("abc", (TupleP([Wildcard, ConstructorP("abc", Wildcard), Wildcard, Variable("xyz")]))) = 0
val test9c_4 = count_some_var ("abc", (TupleP([]))) = 0

val test10_1 = check_pat(TupleP([Wildcard, ConstructorP("abc", Wildcard), Variable("abc"), Wildcard, Variable("xyz"), Variable("abc")])) = false
val test10_2 = check_pat(TupleP([Wildcard, ConstructorP("abc", Wildcard), Variable("abc"), Wildcard, Variable("xyz")])) = true
val test10_3 = check_pat(TupleP([Wildcard, ConstructorP("abc", Wildcard), ConstructorP("abc", Wildcard), Wildcard])) = true
val test10_4 = check_pat(TupleP([])) = true

val test11_01 = match(Const 42, Wildcard) = SOME []
val test11_02 = match(Const 42, ConstP 42) = SOME []
val test11_03 = match(Const 42, ConstP 9) = NONE
val test11_04 = match(Const 42, Variable "Foo") = SOME [("Foo", Const 42)]
val test11_05 = match(Unit, UnitP) = SOME []
val test11_06 = match(Unit, ConstP 42) = NONE
val test11_07 = match(Const 42, UnitP) = NONE
val test11_08 = match(Tuple[Const 5, Const 6, Unit, Const 7], TupleP[Variable "foo", Variable "bar", Variable "baz", Variable "qux"]) = 
		SOME [("foo",Const 5),("bar",Const 6),("baz",Unit),("qux",Const 7)]
val test11_09 = match(Tuple[Const 5, Const 6, Unit, Const 7], TupleP[Variable "foo", Variable "bar", Variable "baz"]) = NONE
val test11_10 = match(Tuple[Const 5, Const 6, Unit, Const 7], TupleP[Variable "foo", Variable "bar", Variable "baz", ConstP 8]) = NONE
val test11_11 = match(Constructor("foo", Const 42), ConstructorP("foo", Wildcard )) = SOME []
val test11_12 = match(Constructor("foo", Const 42), ConstructorP("foo", ConstP 8 )) = NONE
val test11_13 = match(Constructor("foo", Const 42), ConstructorP("bar", Wildcard )) = NONE

val test12_1 = first_match Unit [ConstP 42, ConstructorP("foo", ConstP 8 ), UnitP] = SOME []
val test12_2 = first_match Unit [ConstP 42, ConstructorP("foo", ConstP 8 ), ConstP 9, Variable "foo"] = SOME [("foo", Unit)]
val test12_3 = first_match Unit [ConstP 42, ConstructorP("foo", ConstP 8 ), ConstP 42] = NONE
val test12_4 = first_match Unit [ConstP 42, Variable "bar", UnitP] = SOME [("bar", Unit)]
val test12_5 = first_match Unit [ConstP 42, ConstructorP("foo", ConstP 8 ), Wildcard] = SOME []
val test12_6 = first_match Unit [Variable "baz", UnitP, ConstructorP("foo", ConstP 8 ), UnitP] = SOME [("baz", Unit)]

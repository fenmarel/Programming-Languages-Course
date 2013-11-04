val d0 = (0, 0, 0)
val d1 = (1984, 8, 16)
val d2 = (1969, 3, 5)
val d3 = (2012, 12, 21)
val d4 = (2013, 1, 1)
val d5 = (1832, 1, 9)
val d6 = (1723, 1, 28)
val ld0 = []
val ld1 = [d1, d2]
val ld2 = [d0, d1, d2, d3, d4]
val ld3 = [d4, d3, d2, d1, d0]
val ld4 = [d1, d2, d4, d3]
val ld5 = [d1, d2, d3, d4, d5, d6]
val ld6 = [d4, d5, d6]
val lm1 = [1, 2, 3, 4, 5, 6]
val lm2 = [7, 8, 9, 10, 11, 12]
val ls1 = ["foo", "bar", "baz", "qux", "quux", "corge", "grault", "garply", "waldo", "fred", "plugh", "xyzzy", "thud"]
val ln1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]


val test1_0 = is_older(d1, d1) = false 
val test1_1 = is_older(d2, d1) = true
val test1_2 = is_older(d0, d4) = true
val test1_3 = is_older(d1, d2) = false

val test2_0 = number_in_month([d2], 1) = 0
val test2_1 = number_in_month([d2], 3) = 1
val test2_2 = number_in_month(ld5, 7) = 0
val test2_3 = number_in_month(ld5, 1) = 3

val test3_0 = number_in_months(ld2, lm1) = 2
val test3_1 = number_in_months(ld1, lm1) = 1
val test3_2 = number_in_months(ld1, lm2) = 1
val test3_3 = number_in_months(ld6, lm2) = 0

val test4_0 = dates_in_month([d2], 1) = []
val test4_1 = dates_in_month([d2], 3) = [d2]
val test4_2 = dates_in_month(ld5, 7) = []
val test4_3 = dates_in_month(ld5, 1) = ld6

val test5_0 = dates_in_months(ld2, lm1) = [d4, d2]
val test5_1 = dates_in_months(ld1, lm1) = [d2]
val test5_2 = dates_in_months(ld1, lm2) = [d1]
val test5_3 = dates_in_months(ld6, lm2) = []

val test6_0 = get_nth(ls1, 1) = "foo"
val test6_1 = get_nth(ls1, 3) = "baz"

val test7_0 = date_to_string(d1) = "August 16, 1984"
val test7_1 = date_to_string(d2) = "March 5, 1969"
val test7_2 = date_to_string(d3) = "December 21, 2012"

val test8_0 = number_before_reaching_sum(1, ln1) = 0
val test8_1 = number_before_reaching_sum(8, ln1) = 3
val test8_2 = number_before_reaching_sum(11, ln1) = 4
val test8_3 = number_before_reaching_sum(2, ln1) = 1

val test9_0 = what_month(1) = 1
val test9_1 = what_month(365) = 12
val test9_2 = what_month(40) = 2
val test9_3 = what_month(330) = 11

val test10_0 = month_range(5, 4) = []
val test10_1 = month_range(29, 34) = [1, 1, 1, 2, 2, 2]
val test10_2 = month_range(364, 364) = [12]

val test11_0 = oldest(ld0) = NONE
val test11_1 = oldest(ld1) = SOME(d2)
val test11_2 = oldest(ld2) = SOME(d0)
val test11_3 = oldest(ld3) = SOME(d0)

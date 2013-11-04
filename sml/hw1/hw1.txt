fun is_older (date1 : int*int*int, date2 : int*int*int) =
    #1 date1 < #1 date2 orelse (#1 date1 = #1 date2 andalso #2 date1 < #2 date2) orelse 
    (#1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2)

fun number_in_month (dates : (int*int*int)list, month : int) =
    if null dates
    then 0
    else if #2(hd dates) = month
    then 1 + number_in_month (tl dates, month)
    else 0 + number_in_month (tl dates, month)

fun number_in_months (dates : (int*int*int)list, months : int list) = 
    if null months
    then 0
    else if null (tl months)
    then number_in_month (dates, hd months)
    else number_in_month (dates, hd months) + number_in_months (dates, tl months)

fun dates_in_month (dates : (int*int*int)list, month : int) =
    if null dates
    then []
    else if #2(hd dates) = month
    then (hd dates)::dates_in_month (tl dates, month)
    else dates_in_month (tl dates, month)

fun dates_in_months (dates : (int*int*int)list, months : int list) = 
    if null months
    then []
    else if null (tl months)
    then dates_in_month (dates, hd months)
    else dates_in_month (dates, hd months) @ dates_in_months (dates, tl months)

fun get_nth (words : string list, index : int) =
    if index = 1
    then hd words
    else get_nth (tl words, index - 1)

fun date_to_string (date : int*int*int) = 
    get_nth (["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"], #2 date) ^
    " " ^ Int.toString (#3 date) ^ ", " ^ Int.toString(#1 date)

fun number_before_reaching_sum (sum : int, values : int list) = 
    if sum - (hd values) < 1
    then 0
    else 1 + number_before_reaching_sum (sum - (hd values), tl values)

fun what_month (day : int) =
    1 + number_before_reaching_sum (day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else if day1 = day2
    then what_month (day2) :: []
    else what_month (day1) :: month_range ((day1 + 1), day2)

fun oldest (dates : (int*int*int)list) = 
    if null dates
    then NONE
    else if null (tl dates)
    then SOME (hd dates)
    else if not (is_older ((hd dates), hd(tl dates)))
    then oldest (tl dates)
    else oldest ((hd dates) :: tl(tl dates))

fun number_in_months_challenge (dates : (int*int*int)list, months : int list) = 
    if null months
    then 0
    else if List.exists (fn x => x = hd months) (tl months)
    then number_in_months_challenge (dates, tl months)
    else number_in_month (dates, hd months) + number_in_months_challenge (dates, tl months)

fun dates_in_months_challenge (dates : (int*int*int)list, months : int list) = 
    if null months
    then []
    else if List.exists (fn x => x = hd months) (tl months)
    then dates_in_months_challenge (dates, tl months)
    else dates_in_month (dates, hd months) @ dates_in_months_challenge (dates, tl months)

fun reasonable_date (date : int*int*int) = 
    if (#1 date) < 1 orelse (#2 date) < 1 orelse (#2 date) > 12 orelse (#3 date) < 1
    then false
    else if #2 date = 2 andalso #3 date = 29
    then ((#1 date) mod 400 = 0 orelse (#1 date) mod 4 = 0) andalso (#1 date) mod 100 <> 0
    else let fun daycheck (daylist : int list, index : int) = 
		 if index = 1
		 then hd daylist
		 else daycheck (tl daylist, index - 1)
	 in daycheck ([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], (#2 date)) >= (#3 date)
	 end 
	     
											 

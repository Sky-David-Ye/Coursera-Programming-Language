fun is_older(year1 : int*int*int, year2 : int*int*int) = 
    if (#1 year1) <> (#1 year2)
    then (#1 year1) < (#1 year2)
    else if (#2 year1) <> (#2 year2)
        then (#2 year1) < (#2 year2)
        else (#3 year1) < (#3 year2)

fun number_in_month(list_date : (int * int * int) list, month : int) = 
    if null list_date
    then 0
    else 
        if (#2 (hd list_date)) = month
        then 1 + number_in_month(tl list_date, month)
        else number_in_month(tl list_date, month) 

fun number_in_months(list_date : (int * int * int) list, months : int list) =
    if null months
    then 0
    else
        number_in_month(list_date, (hd months)) + number_in_months(list_date, (tl months))

fun dates_in_month(list_date : (int * int * int) list, month : int) = 
    if null list_date
    then []
    else
        if (#2 (hd list_date)) = month
        then (hd list_date)::dates_in_month(tl list_date, month)
        else dates_in_month(tl list_date, month) 

fun dates_in_months(list_date : (int * int * int) list, months : int list) = 
    if null months
    then []
    else dates_in_month(list_date, hd months) @ dates_in_months(list_date, tl months)

fun get_nth(list_str : string list, n : int) = 
    if n = 1
    then hd list_str
    else
        get_nth(tl list_str, n - 1)

fun date_to_string(date: (int * int * int)) = 
    let
        val months = ["January", "February", "March", "April",
"May", "June", "July", "August", "September", "October", "November", "December"]
    in
        get_nth(months, (#2 date)) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum(sum : int, int_list : int list) = 
    if sum <= (hd int_list)
    then 0
    else 1 + number_before_reaching_sum(sum - (hd int_list), (tl int_list))

fun what_month(date : int) = 
    let
        val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(date, days) + 1
    end

fun month_range(day1 : int, day2 : int) = 
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1+1, day2)

fun oldest(list_date : (int * int * int) list) = 
    if null list_date
    then NONE
    else
        let
            fun oldest_date(dates : (int * int * int) list) = 
                if null (tl dates)
                then (hd dates)
                else
                    let
                        val rest_oldest = oldest_date(tl dates)
                    in
                        if is_older(hd dates, rest_oldest)
                        then (hd dates)
                        else rest_oldest
                    end
        in
            SOME (oldest_date(list_date))
        end
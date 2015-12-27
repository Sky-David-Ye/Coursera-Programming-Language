use "hw1.sml";


val is_older_test1 = is_older((1985,11,16),(1985,11,16)) = false
val is_older_test2 = is_older((1985,11,16),(1985,11,15)) = false
val is_older_test3 = is_older((1985,11,16),(1985,11,17)) = true
val is_older_test4 = is_older((1985,11,16),(1985,10,16)) = false
val is_older_test5 = is_older((1985,11,16),(1985,12,16)) = true
val is_older_test6 = is_older((1985,11,16),(1984,11,16)) = false
val is_older_test7 = is_older((1985,11,16),(1986,11,16)) = true

val number_in_month_test1 = number_in_month([], 3) = 0
val number_in_month_test2 = number_in_month([(1985,11,16)], 3) = 0
val number_in_month_test3 = number_in_month([(1985,11,16),(1988,7,11)], 3) = 0
val number_in_month_test4 = number_in_month([(1985,11,16),(1988,3,17),(1988,7,29)], 3) = 1
val number_in_month_test5 = number_in_month([(1985,11,16),(1977,3,4),(1988,7,29),(19,3,1)], 3) = 2

val number_in_months_test1 = number_in_months([], []) = 0
val number_in_months_test2 = number_in_months([], [3,4,5]) = 0
val number_in_months_test3 = number_in_months([(1985,11,16),(1988,7,29)], []) = 0
val number_in_months_test4 = number_in_months([(1985,11,16),(1977,3,4),(1988,7,29),(19,3,1)], [3]) = 2
val number_in_months_test5 = number_in_months([(1985,11,16),(1977,3,4),(1988,7,29),(19,3,1)], [3,11,7]) = 4

val dates_in_month_test1 = dates_in_month([], 3) = []
val dates_in_month_test2 = dates_in_month([(1985,11,16)], 1) = []
val dates_in_month_test3 = dates_in_month([(1985,11,16)], 11) = [(1985,11,16)]
val dates_in_month_test4 = dates_in_month([(1985,11,16),(1977,3,4),(1988,7,29),(19,3,1)], 3) = [(1977,3,4),(19,3,1)]

val dates_in_months_test1 = dates_in_months([], []) = []
val dates_in_months_test2 = dates_in_months([], [1,2]) = []
val dates_in_months_test3 = dates_in_months([(1985,11,16),(1977,3,4)], []) = []
val dates_in_months_test4 = dates_in_months([(1985,11,16),(1977,3,4)], [7,8]) = []
val dates_in_months_test5 = dates_in_months([(1985,11,16),(1977,3,4),(293847,4,23)], [3,4]) = [(1977,3,4),(293847,4,23)]



val get_nth_test1 = get_nth(["hi"], 1) = "hi"
val get_nth_test2 = get_nth(["hi", "ho", "ha", "hu"], 1) = "hi"
val get_nth_test3 = get_nth(["hi", "ho", "ha", "hu"], 2) = "ho"
val get_nth_test4 = get_nth(["hi", "ho", "ha", "hu"], 3) = "ha"
val get_nth_test5 = get_nth(["hi", "ho", "ha", "hu"], 4) = "hu"

val date_to_string_test1 = date_to_string((1,1,1)) = "January 1, 1"
val date_to_string_test2 = date_to_string((1985,11,16)) = "November 16, 1985"
val number_before_reaching_sum_test1 = number_before_reaching_sum(0, [1,2,3,4,5]) = 0
val number_before_reaching_sum_test2 = number_before_reaching_sum(10, [1,2,3,4,5,6,7]) = 3
val number_before_reaching_sum_test3 = number_before_reaching_sum(11, [1,2,3,4,5,6,7]) = 4

val what_month_test1 = what_month(1) = 1
val what_month_test2 = what_month(31) = 1
val what_month_test3 = what_month(32) = 2
val what_month_test4 = what_month(59) = 2
val what_month_test5 = what_month(60) = 3
val what_month_test6 = what_month(365) = 12

val month_range_test1 = month_range(3,1) = []
val month_range_test2 = month_range(3,3) = [1]
val month_range_test3 = month_range(31,33) = [1,2,2]

val oldest_test1 = oldest([]) = NONE
val oldest_test2 = oldest([(1985,11,16)]) = SOME((1985,11,16))
val oldest_test3 = oldest([(1985,11,16),(1955,11,17),(1912,10,17),(1989,1,12)]) = SOME((1912,10,17))




val newyear1 = (2011,1,1);
val newyear2 = (2012,1,1);
val newyear3 = (2013,1,1);
val christmas1 = (2011,12,25);
val christmas2 = (2012,12,25);
val christmas3 = (2013,12,25);
val july1 = (2011,7,4);
val july2 = (2012,7,4);
val july3 = (2013,7,4);
val months = [31,28,31,30,31,30,31,31,30,31,30,31];

(* TEST IS_OLDER *)
val test_is_older1 = is_older(newyear1, newyear2) = true;
val test_is_older2 = is_older(newyear2, newyear3) = true;
val test_is_older3 = is_older(newyear1, newyear3) = true;
val test_is_older4 = is_older(newyear2, newyear1) = false;
val test_is_older5 = is_older(newyear2, newyear2) = false;

(* TEST NUMBER_IN_MONTH *)
val test_num1 = number_in_month([newyear1,newyear2,july1,july2],1) = 2;
val test_num2 = number_in_month([newyear1,newyear2, newyear3,july1,july2],1) = 3;
val test_num3 = number_in_month([newyear1,newyear2,july1,july2],2) = 0;
val test_num4 = number_in_month([newyear1,newyear2,july1,july2],7) = 2;

(* TEST NUMBER_IN_MONTHS *)
val test_num_months1 = number_in_months([newyear1,newyear2,july1,july2],[1,7]) = 4;
val test_num_months2 = number_in_months([newyear1,newyear2, newyear3,july1,july2],[1,3,6,7]) = 5;
val test_num_months3 = number_in_months([newyear1,newyear2,july1,july2],[2]) = 0;
val test_num_months4 = number_in_months([newyear1,newyear2,july1,july2],[7]) = 2;

(* TEST DATES_IN_MONTH *)

val test_dates_month1 = dates_in_month([newyear1,newyear2,july1,july2],1) = [newyear1,newyear2];
val test_dates_month2 = dates_in_month([newyear1,newyear2, newyear3,july1,july2],7) = [july1,july2];
val test_dates_month3 = dates_in_month([newyear1,newyear2,july1,july2],2) = [];
val test_dates_month4 = dates_in_month([newyear1,newyear2,july1,july2],7) = [july1,july2];

(* TEST DATES_IN_MONTHS *)

val test_dates_months1 = dates_in_months([newyear1,newyear2,july1,july2],[1,7]) = [newyear1,newyear2, july1, july2];
val test_dates_months2 = dates_in_months([newyear1,newyear2, newyear3,july1,july2],[2,7,8,9]) = [july1,july2];
val test_dates_months3 = dates_in_months([newyear1,newyear2,july1,july2],[2]) = [];
val test_dates_months4 = dates_in_months([newyear1,newyear2,july1,july2],[7]) = [july1,july2];

(* TEST GET_NTH *)
val test1 = get_nth(["hi","class","coursera","is","awesome"],3)="coursera";
val test2 = get_nth(["hi","class","coursera","is","awesome"],4)="is";
val test3 = get_nth(["hi","class","coursera","is","awesome"],5)="awesome";
(*val test4 = get_nth(["hi","class","coursera","is","awesome"],6)="";*)

(* TEST DATE_TO_STRING *)

val dts1 = date_to_string(newyear1) = "January 1, 2011";
val dts2 = date_to_string(newyear2) = "January 1, 2012";
val dts3 = date_to_string(july1) = "July 4, 2011";

(* TEST WHAT_MONTH *)

val wm1 = what_month(1) = 1;
val wm2 = what_month(50) = 2;
val wm3 = what_month(365) = 12;
val wm4 = what_month(100) = 4;

(* TEST OLDEST *)

val old1 = oldest([newyear1,newyear2,newyear3]) = SOME newyear1;
val old2 = oldest([newyear3,newyear2,newyear1]) = SOME newyear1;
val old3 = oldest([july1,christmas1,newyear3]) = SOME july1;
val old4 = oldest([]) = NONE;



val nbrs5 = number_before_reaching_sum(1, [2]) = 0 ;
val nbrs6 = number_before_reaching_sum(5, [3,1,2]) = 2 ;
val nbrs7 = number_before_reaching_sum(5, [3,2,2]) = 1;
val nbrs8 = number_before_reaching_sum(4, [1,4,1,1]) = 1;
val nbrs9 = number_before_reaching_sum(6, [4,1,1,1]) = 2;
val nbrs10 = number_before_reaching_sum(10, [1,2,3,4,5]) = 3;
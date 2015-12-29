(* Dan Grossman, CSE341 Spring 2013, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(s, xs) = 
    case xs of
        [] => NONE
        | x::xs' => if same_string(x, s) then (SOME xs') else
                        case all_except_option(s, xs') of
                            NONE => NONE
                            | SOME lst => SOME (x::lst)

fun get_substitutions1(s_list_list, s) = 
    case s_list_list of 
        [] => []
        | xs::s_list_list' => case all_except_option(s, xs) of
            NONE => get_substitutions1(s_list_list', s)
            | SOME lst => lst @ get_substitutions1(s_list_list', s)

fun get_substitutions2(s_list_list, s) = 
    let
        fun aux(s_list_list, acc) =
             case s_list_list of
                 [] => acc
                 | xs::s_list_list' => case all_except_option(s, xs) of
                     NONE => aux(s_list_list', acc)
                     | SOME lst => aux(s_list_list', acc @ lst)
    in
        aux(s_list_list, [])
    end

fun similar_names(s_list_list, {first=s, middle=y, last=z}) =
    let
        val xs = get_substitutions1(s_list_list, s)
        fun aux (xs, acc) =
            case xs of
                [] => acc 
                | x::xs' => aux(xs', acc @ [{first=x, middle=y, last=z}])
    in
        {first=s, middle=y, last=z}::aux(xs, [])
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color card = 
    case card of
        (Clubs, _) => Black
        | (Spades, _) => Black
        | (Diamonds, _) => Red
        | (Hearts, _) => Red

fun card_value card = 
    case  card of
        (_, Ace) => 11
        | (_, Num x) => x
        | _ => 10

fun remove_card(cs, c, e) =
    case cs of
         [] => raise e
         | x::xs' => if x=c then xs' else x::remove_card(xs', c, e)

fun all_same_color(cs) = 
    case cs of
        [] => true
        | [x] => true
        | x::y::xs => if card_color(x) = card_color(y) then all_same_color(y::xs) else false

fun sum_cards cs = 
    let
        fun aux(cs, acc) =
             case cs of
                 [] => acc
                 | x::xs => aux(xs, acc+card_value(x))
    in
        aux(cs, 0)
    end

fun score (cs, goal) =
    let
        val sum = sum_cards(cs)
        val pre_score = if sum>goal then 3*(sum-goal) else goal-sum
    in
        if all_same_color(cs) then pre_score div 2 else pre_score
    end

fun officiate(cs, ms, goal) = 
    let
        fun helper(cs, hs, ms) =
            case ms of
                [] => score(hs, goal)
                | m::ms' => case m of
                    Discard card => helper(cs, remove_card(hs, card, IllegalMove), ms')
                    | Draw => case cs of
                        [] => score(hs, goal)
                        | c::cs' => let
                            val hs' = c::hs
                        in
                            if score(hs', goal) > goal then score(hs', goal) else helper(cs', hs', ms') 
                        end
    in
        helper(cs, [], ms)
    end
(* Dan Grossman, CSE341 Spring 2013, HW3 Provided Code *)

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

(**** for the challenge problem only ****)

datatype typ = Anything
         | UnitT
         | IntT
         | TupleT of typ list
         | Datatype of string

(**** you can put all your code here ****)

fun only_capitals str_list =
  List.filter (Char.isUpper o (fn s => String.sub(s, 0))) str_list

fun longest_string1 str_list =
  List.foldl(fn (x, s) => if String.size(s) >= String.size(x) then s else x) "" str_list

fun longest_string2 str_list =
  List.foldl(fn (x, s) => if String.size(s) > String.size(x) then s else x) "" str_list

fun longest_string_helper f str_list = 
  List.foldl(fn (x, s) => if f(x,s) then s else x) "" str_list

val longest_string3 = longest_string_helper (fn (x, s) => String.size(s) >= String.size(x))

val longest_string4 = longest_string_helper (fn (x, s) => String.size(s) > String.size(x))

val longest_capitalized = longest_string3 o only_capitals

val rev_string  = String.implode o List.rev o String.explode 

fun first_answer f xs =
  case xs of
    [] => raise NoAnswer
    | x::xs' => case f x of
      NONE => first_answer f xs'
      | SOME v => v

(* with aux helper function *)
(*fun all_answers f xs = 
  case xs of
    [] => SOME []
    | x::xs' => case f x of
      NONE => NONE
      | SOME [v] => let
                    val next = all_answers f xs'
                    in
                      case next of
                        NONE => NONE
                        | SOME y => SOME(v::y)
                    end*)

fun all_answers f xs = 
  let
    fun aux (f, xs, acc) =
       case xs of
         [] => SOME acc
         | x::xs' => case f x of
           NONE => NONE
           | SOME lst => aux(f, xs', lst@acc)
  in
    aux(f, xs, [])
  end


val count_wildcards = g (fn () => 1) (fn x => 0) 
val count_wild_and_variable_lengths = g (fn () => 1) (fn x => String.size(x))
fun count_some_var (s, p) = ((g (fn () => 0) (fn x => if x=s then 1 else 0)) o ConstructorP) (s, p)  

fun all_string p =
    case p of
       Variable x        => [x]
      | TupleP ps         => List.foldl (fn (p,i) => (all_string p) @ i) [] ps
      | ConstructorP(_,p) => all_string p
      | _                 => []

fun is_repeated xs = 
  case xs of
    [] => true
    | x::xs' => if List.exists (fn x' => x=x') xs' then false else is_repeated xs'

val check_pat = is_repeated o all_string

fun match (valu, pattern) = 
  case (pattern, valu) of
    (Wildcard, _) => SOME []
    | (Variable s, _) => SOME [(s, valu)]
    | (UnitP, Unit) => SOME []
    | (ConstP i1, Const i2) => if i1=i2 then SOME [] else NONE
    | (ConstructorP (s1, p), Constructor (s2, v)) => if s1=s2 then match(v, p) else NONE
    | (TupleP ps, Tuple vs) => if List.length(ps) <> List.length(vs) 
                               then NONE 
                               else 
                                  all_answers match (ListPair.zip(vs, ps))
    | _ => NONE

fun first_match valu xs =
  SOME (first_answer (fn x => match(valu, x)) xs) handle NoAnswer => NONE
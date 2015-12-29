use "hw2.sml";

val all_except_option_test1 = all_except_option("1", []) = NONE
val all_except_option_test2 = all_except_option("1", ["1", "2", "3"]) = SOME(["2", "3"])
val all_except_option_test3 = all_except_option("2", ["1", "2", "3"]) = SOME(["1", "3"])
val all_except_option_test4 = all_except_option("3", ["1", "2", "3"]) = SOME(["1", "2"])
val all_except_option_test5 = all_except_option("4", ["1", "2", "3"]) = NONE

val get_substitutions1_test1 = get_substitutions1([["Fred","Frederick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Frederick","Freddie","F"]
val get_substitutions1_test2 = get_substitutions1([["Fred","Frederick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val get_substitutions2_test1 = get_substitutions2([["Fred","Frederick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], "Fred") = ["Frederick","Freddie","F"]
val get_substitutions2_test2 = get_substitutions2([["Fred","Frederick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]], "Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val similar_names_test1 = similar_names([["Fred","Frederick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"}, {first="Frederick", last = "Smith", middle="W"}, {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val similar_names_test2 = similar_names([], {first="test", middle="test", last="test"}) = [{first="test", middle="test", last="test"}]

val card_color_test1 = card_color((Spades, Num 8)) = Black
val card_color_test2 = card_color((Clubs, Ace)) = Black
val card_color_test3 = card_color((Hearts, Num 3)) = Red
val card_color_test4 = card_color((Diamonds, Jack)) = Red

val card_value_test1 = card_value((Spades, Num 8)) = 8
val card_value_test2 = card_value((Clubs, Ace)) = 11
val card_value_test3 = card_value((Diamonds, Jack)) = 10

val remove_card_test1 = remove_card([(Spades, Ace),(Diamonds,Jack)], (Spades, Ace), IllegalMove) = [(Diamonds,Jack)]

val all_same_color_test1 = all_same_color([(Spades, Ace),(Spades, Num 3)]) = true
val all_same_color_test2 = all_same_color([(Spades, Ace),(Spades, Num 3),(Hearts, Jack)]) = false

val sum_cards_test1 = sum_cards([(Spades, Ace),(Spades, Num 3),(Hearts, Jack)]) = 24

val score_test1 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val officiate_test1 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val officiate_test2 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3

val officiate_test3 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       39)
             = 7

val officiate_test4 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false)
              handle IllegalMove => true)


val test1 = all_except_option("string", ["string"]) = SOME []

val test2 = get_substitutions1([["foo"],["there"]], "foo") = []

val test3 = get_substitutions2([["foo"],["there"]], "foo") = []

val test4 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
        [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
         {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]

val test5 = card_color((Clubs, Num 2)) = Black

val test6 = card_value((Clubs, Num 2)) = 2

val test7 = remove_card([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []

val test8 = all_same_color([(Hearts, Ace), (Hearts, Ace)]) = true

val test9 = sum_cards([(Clubs, Num 2),(Clubs, Num 2)]) = 4

val test10 = score([(Hearts, Num 2),(Clubs, Num 4)],10) = 4

val test11 = officiate([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       42)
             = 3

val test13 = officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                       [Draw,Draw,Draw,Draw,Draw],
                       39)
             = 7

val test14 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false)
              handle IllegalMove => true)
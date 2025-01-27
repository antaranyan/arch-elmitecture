module Main exposing (..)

import Allergies
import Browser
import Html exposing (Html, br, div, input, text)
import Html.Attributes exposing (placeholder, style, value)
import Html.Events exposing (onInput)
import List
import Maybe exposing (withDefault)
import String exposing (toInt)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Int


init : Model
init =
    0


type Msg
    = Change String


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Change newScore ->
            toInt newScore |> withDefault 0


toPresentable : Int -> String
toPresentable =
    Allergies.toList >> List.map Allergies.toEmoji >> List.intersperse " " >> List.foldr (++) ""


view : Model -> Html Msg
view model =
    div
        [ style "display" "grid"
        , style "justify-content" "center"
        , style "align-content" "center"
        , style "grid-auto-flow" "row"
        , style "gap" "20px"
        , style "align-items" "center"
        , style "justify-items" "center"
        , style "background-image" "url('background.jpg')"
        , style "opacity" "0.4"
        , style "height" "1300px" -- consider to changing to screen size
        ]
        [ allergiesText
        , paiskavik model
        , describtion
        ]


allergiesText =
    div [ style "font-size" "1300%", style "margin-bottom" "3%" ] [ text "Allergies" ]


paiskavik : Model -> Html Msg
paiskavik model =
    div
        [ style "font-size" "325%"
        , style "display" "flex"
        , style "flex-direction" "column"
        , style "padding" "2.5% 7% 2.5% 7%"
        , style "background-color" "#2E8BC0"
        , style "border" "2px solid #000000"
        , style "border-radius" "25px"
        , style "width" "30%"
        ]
        [ input [ placeholder "score", value (Debug.toString model), onInput Change ] []
        , div [] [ text (toPresentable model) ]
        ]


describtion : Html msg
describtion =
    div
        [ style "margin-top" "5%"
        , style "font-weight" "1000"
        , style "border-style" "dashed"
        , style "padding" "3%"
        , style "background-color" "#FFFFFF"
        , style "opacity" "0.8"
        ]
        (List.intersperse (br [] []) <|
            [ text "Enter a person's allergy score, determine their full list of allergies."
            , text "An allergy test produces a single numeric score which contains the information about all the allergies the person has."
            , text "The list of items (and their value) that were tested are:"
            , text " "
            , text "- eggs (1)"
            , text "- peanuts (2)"
            , text "- shellfish (4)"
            , text "- strawberries (8)"
            , text "- tomatoes (16)"
            , text "- chocolate (32)"
            , text "- pollen (64)"
            , text "- cats (128)"
            , text " "
            , text "So if Tom is allergic to peanuts and chocolate, he gets a score of 34."
            ]
        )

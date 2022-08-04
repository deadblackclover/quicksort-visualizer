module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { sourceList : List Int
    , sortList : List Int
    }


init : Model
init =
    { sourceList = [ 10, 1, 7, 5, 2, 3, 6, 4, 8, 9 ]
    , sortList = []
    }



-- UPDATE


type Msg
    = Sort


quicksort : List Int -> List Int
quicksort list =
    case list of
        [] ->
            []

        x :: xs ->
            let
                lower =
                    quicksort (List.filter ((>=) x) xs)

                higher =
                    quicksort (List.filter ((<) x) xs)
            in
            lower ++ [ x ] ++ higher


update : Msg -> Model -> Model
update msg model =
    case msg of
        Sort ->
            { model | sortList = quicksort model.sourceList }



-- VIEW


itemView : Int -> Html Msg
itemView item =
    div [ class "item", style "height" (String.fromInt (item * 10) ++ "px") ] []


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Sort ] [ text "Sort" ]
        , div [ class "list" ] (List.map itemView model.sourceList)
        , div [ class "list" ] (List.map itemView model.sortList)
        ]

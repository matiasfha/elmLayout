module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Layout exposing (..)


main : Program Never
main =
    App.beginnerProgram { model = state, view = view, update = update }


type alias Model =
    { direction : String
    , parallel : String
    , perpendicular : String
    }


state : Model
state =
    Model "row" "start" "center"


type Msg
    = ToggleRow
    | ToggleColumn


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleRow ->
            { model | direction = "row" }

        ToggleColumn ->
            { model | direction = "column" }


checkbox : List (Attribute msg) -> msg -> String -> Html msg
checkbox attributes msg name =
    label
        [ style [ ( "padding", "20px" ) ]
        ]
        [ input (List.concat [ attributes, [ type' "checkbox", onClick msg ] ]) []
        , text name
        ]


sampleLayout : Model -> Html Msg
sampleLayout model =
    layout
        [ direction ( "row", False )
        , alignPara "center"
        , alignPerpen "center"
        ]
        [ flex [ Layout.size "70", order 2 ]
            [ div
                [ style
                    [ ( "backgroundColor", "red" )
                    , ( "color", "white" )
                    ]
                ]
                [ text "Hello World - Order 1" ]
            ]
        , flex [ Layout.size "10", order 3 ]
            [ div
                [ style
                    [ ( "backgroundColor", "blue" )
                    , ( "color", "white" )
                    ]
                ]
                [ text "Hello World - Order 2" ]
            ]
        , flex [ Layout.size "20", order 1 ]
            [ div
                [ style
                    [ ( "backgroundColor", "green" )
                    , ( "color", "white" )
                    ]
                ]
                [ text "Hello World - Order 3" ]
            ]
        ]


view : Model -> Html Msg
view model =
    sampleLayout model

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
    { direction : Direction
    , parallel : Alignment
    , perpendicular : Alignment
    }


state : Model
state =
    Model Column Start Center


type Msg
    = ToggleRow
    | ToggleColumn


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleRow ->
            { model | direction = Row }

        ToggleColumn ->
            { model | direction = Column }


checkbox : List (Attribute msg) -> msg -> String -> Html msg
checkbox attributes msg name =
    label
        [ style [ ( "padding", "20px" ) ]
        ]
        [ input (List.concat [ attributes, [ type' "radio", onClick msg ] ]) []
        , text name
        ]


getElement : Model -> List LAttr -> List (Html msg) -> Html msg
getElement model =
    case model.direction of
        Row ->
            row

        Column ->
            column


view : Model -> Html Msg
view model =
    (getElement model) [ Layout.size "80", alignPara Center, alignPerpen Center ]
        [ flex [ Layout.size "70", order 1 ]
            [ div
                [ style
                    [ ( "backgroundColor", "red" )
                    , ( "color", "white" )
                    , ( "height", "100%" )
                    , ( "width", "100%" )
                    ]
                ]
                [ checkbox [ name "toggle", checked (model.direction == Row) ] ToggleRow "Toggle Row First in HTML - Order 1" ]
            ]
        , flex [ Layout.size "40", order 3 ]
            [ div
                [ style
                    [ ( "backgroundColor", "blue" )
                    , ( "color", "white" )
                    , ( "height", "100%" )
                    , ( "width", "100%" )
                    ]
                ]
                [ checkbox [ name "toggle", checked (model.direction == Column) ] ToggleColumn "Toggle Column Second in HTML - Order 3" ]
            ]
        , flex [ Layout.size "90", order 2 ]
            [ div
                [ style
                    [ ( "backgroundColor", "green" )
                    , ( "color", "white" )
                    , ( "height", "100%" )
                    , ( "width", "100%" )
                    ]
                ]
                [ text "Third in Html - Order 2" ]
            ]
        ]

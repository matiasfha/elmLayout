module Main exposing (..)

import Html exposing (..)
import Layout exposing (..)


children : Html a
children =
    div []
        [ text "Hola Mundo"
        ]


main : Html a
main =
    div []
        [ layout { align = Just "center center", direction = Just "row", reverse = Nothing, size = Just "20", order = Nothing, wrap = Nothing, fill = Nothing }
            children
        , layout
            { align = Just "center center", direction = Just "row", reverse = Nothing, size = Just "20", order = Nothing, wrap = Nothing, fill = Just True }
            (div [] [ text "Hola dos" ])
        ]

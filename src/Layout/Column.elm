module Layout.Column exposing (column)

import Html exposing (..)
import Layout.Types exposing (..)
import Layout.Attributes exposing (..)
import Layout.Layout exposing (layout)


column : List LAttr -> List (Html msg) -> Html msg
column params children =
    let
        baseParams =
            List.concat [ [ direction ( Column, False ) ], params ]
    in
        layout baseParams children

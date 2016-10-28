module Layout.Row exposing (row)

import Html exposing (..)
import Layout.Types exposing (..)
import Layout.Attributes exposing (..)
import Layout.Layout exposing (layout)


row : List LAttr -> List (Html msg) -> Html msg
row params children =
    let
        baseParams =
            List.concat [ [ direction ( Row, False ) ], params ]
    in
        layout baseParams children

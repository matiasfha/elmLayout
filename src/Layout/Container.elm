module Layout.Container exposing (container)

import Html exposing (..)
import Layout.Types exposing (..)
import Layout.Attributes exposing (..)
import Layout.Layout exposing (layout)


container : List LAttr -> List (Html msg) -> Html msg
container params children =
    layout [ fill True, wrap False ]
        [ (layout params children)
        ]

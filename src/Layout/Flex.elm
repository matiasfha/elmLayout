module Layout.Flex exposing (flex)

import Html exposing (..)
import Layout.Types exposing (..)
import Layout.Helpers exposing (..)


flex : List LAttr -> List (Html msg) -> Html msg
flex params children =
    div
        (getClassList params)
        children

module Layout.Layout exposing (layout)

import Html exposing (..)
import Layout.Grid exposing (styleNamespace)
import Layout.Helpers exposing (..)
import Layout.Attributes exposing (..)
import Layout.Types exposing (..)


{ id, class, classList, name } =
    styleNamespace
layout : List LAttr -> List (Html msg) -> Html msg
layout params children =
    case List.isEmpty (Debug.log "params" params) of
        True ->
            div
                (getClassList
                    [ direction ( Row, False )
                    , alignPara Start
                    , alignPerpen Stretch
                    ]
                )
                children

        False ->
            -- default parameters
            div (getClassList params) children

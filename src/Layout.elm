module Layout
    exposing
        ( layout
        , flex
        , container
        , alignPerpen
        , alignPara
        , size
        , direction
        , fill
        , wrap
        , order
        )

import Html exposing (..)
import Layout.Grid exposing (styleNamespace)
import Layout.Helpers exposing (..)
import Layout.Attributes as Attr exposing (..)


{ id, class, classList, name } =
    styleNamespace
layout : List LAttr -> List (Html msg) -> Html msg
layout params children =
    case List.isEmpty (Debug.log "params" params) of
        True ->
            node "layout"
                (getClassList
                    [ direction ( "row", False )
                    , alignPara "start"
                    , alignPerpen "stretch"
                    ]
                )
                children

        False ->
            -- default parameters
            node "layout" (getClassList params) children


flex : List LAttr -> List (Html msg) -> Html msg
flex params children =
    node "flex"
        (getClassList params)
        children



{-
   * Utility for centering Layouts inside other Layouts, has the same parameters
   * as the `layout` element, but it always fills the parent component.
   * (from http://stackoverflow.com/questions/15381172/css-flexbox-child-height-100)
-}


container : List LAttr -> List (Html msg) -> Html msg
container params children =
    layout [ fill True, wrap False ]
        [ (layout params children)
        ]



{- Attributes -}


alignPerpen : String -> LAttr
alignPerpen str =
    Attr.alignPerpen str


alignPara : String -> LAttr
alignPara str =
    Attr.alignPara str


size : String -> LAttr
size str =
    Attr.size str


direction : ( String, Bool ) -> LAttr
direction ( str, reverse ) =
    Attr.direction ( str, reverse )


fill : Bool -> LAttr
fill bool =
    Attr.fill bool


wrap : Bool -> LAttr
wrap bool =
    Attr.wrap bool


order : Int -> LAttr
order number =
    Attr.order number

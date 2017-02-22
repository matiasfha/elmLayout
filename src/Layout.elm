module Layout
    exposing
        ( layout
        , row
        , column
        , flex
        , container
        , alignPerpen
        , alignPara
        , size
        , direction
        , fill
        , wrap
        , order
        , Direction
        , Alignment
        , LAttr
        )

import Html exposing (..)
import Layout.Types exposing (..)
import Layout.Layout as Layout exposing (layout)
import Layout.Column as Column exposing (column)
import Layout.Row as Row exposing (row)
import Layout.Flex as Flex exposing (flex)
import Layout.Container as Container exposing (container)
import Layout.Attributes as Attr exposing (..)
import Layout.Types as Types


{--Types --}


type alias Direction =
    Layout.Types.Direction


type alias LAttr =
    Types.LAttr


type alias Alignment =
    Types.Alignment



-- = Start
-- | Center
-- | End'
-- | SpaceAround
-- | SpaceBetween
-- | Stretch
{--Elements --}


layout : List LAttr -> List (Html msg) -> Html msg
layout =
    Layout.layout


column : List LAttr -> List (Html msg) -> Html msg
column =
    Column.column


row : List LAttr -> List (Html msg) -> Html msg
row =
    Row.row


flex : List LAttr -> List (Html msg) -> Html msg
flex =
    Flex.flex


container : List LAttr -> List (Html msg) -> Html msg
container =
    Container.container



{- Attributes -}


alignPerpen : Types.Alignment -> LAttr
alignPerpen =
    Attr.alignPerpen


alignPara : Types.Alignment -> LAttr
alignPara =
    Attr.alignPara


size : String -> LAttr
size =
    Attr.size


direction : ( Types.Direction, Bool ) -> LAttr
direction =
    Attr.direction


fill : Bool -> LAttr
fill =
    Attr.fill


wrap : Bool -> LAttr
wrap =
    Attr.wrap


order : Int -> LAttr
order number =
    Attr.order number

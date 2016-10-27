module Layout.Helpers exposing (parseAlign, parseDirection, parseSize, parseOrder, parseWrap, parseFill, getClassList)

import String exposing (concat)
import Html exposing (Attribute)
import Array exposing (fromList)
import Layout.Grid exposing (CssClasses(..), styleNamespace)


{ id, class, classList, name } =
    styleNamespace



-- TODO this is repeated here and in Attributes.elm


type alias LAttr =
    { value : String
    , active : Bool
    }


type Alignment
    = Start
    | Center
    | End'
    | SpaceAround
    | SpaceBetween
    | Stretch


getClassList : List LAttr -> List (Attribute a)
getClassList params =
    let
        classes =
            List.map (\item -> ( item.value, item.active ))
    in
        [ classList (classes params) ]


toAlignment : String -> Alignment
toAlignment string =
    case string of
        "start" ->
            Start

        "center" ->
            Center

        "end" ->
            End'

        "space-around" ->
            SpaceAround

        "space-between" ->
            SpaceBetween

        "stretch" ->
            Stretch

        _ ->
            Start


getAlignment : String -> Alignment -> String
getAlignment type' value =
    case value of
        Start ->
            case type' of
                "perpendicular" ->
                    toString AlignPerpendicularStart

                "parallel" ->
                    toString AlignParallelStart

                _ ->
                    ""

        Center ->
            case type' of
                "perpendicular" ->
                    toString AlignPerpendicularCenter

                "parallel" ->
                    toString AlignParallelCenter

                _ ->
                    ""

        End' ->
            case type' of
                "perpendicular" ->
                    toString AlignPerpendicularEnd

                "parallel" ->
                    toString AlignParallelEnd

                _ ->
                    ""

        SpaceAround ->
            toString AlignParallelSpaceAround

        SpaceBetween ->
            toString AlignParallelSpaceBetween

        Stretch ->
            toString AlignPerpendicularStretch


parseAlign : String -> { parallel : String, perpendicular : String }
parseAlign align =
    let
        aligns =
            Array.fromList (String.split " " align)

        parallel =
            toAlignment (String.toLower (Maybe.withDefault "start" (Array.get 0 aligns)))

        perpendicular =
            toAlignment (String.toLower (Maybe.withDefault "stretch" (Array.get 1 aligns)))
    in
        { parallel = getAlignment "parallel" parallel
        , perpendicular = getAlignment "perpendicular" perpendicular
        }


parseDirection : String -> Bool -> String
parseDirection direction reverse =
    if direction == "row" then
        if reverse == True then
            toString LayoutRowReverse
        else
            toString LayoutRow
    else if reverse == True then
        toString LayoutColumnReverse
    else
        toString LayoutColumn


parseSize : String -> String
parseSize size =
    toString (FlexSize size)


parseOrder : Int -> String
parseOrder order =
    toString (FlexOrder order)


parseWrap : Bool -> String
parseWrap wrap =
    if wrap == True then
        toString Wrap
    else
        toString NoWrap


parseFill : Bool -> String
parseFill fill =
    toString Fill

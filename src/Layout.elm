module Layout exposing (layout, LayoutParams)

import Html exposing (..)
import Grid exposing (..)
import String exposing (concat)
import Array exposing (fromList, get)


{ id, class, classList, name } =
    styleNamespace



{-
   * The <Layout /> element works as the container of many child flexboxes.
   * Its direction determines whether the children display forming rows or columns
   * across its length.
   * The align parameter is a string that determines where are the children placed
   * and aligned. Its composed in two parts; parallel and perpendicular.
   * Parallel:
   * - start (default)
   * - center
   * - end
   * - space around
   * - space between
   * Perpendicular:
   * - start
   * - center
   * - end
   * - stretch (default)
   * Note: the <Layout /> component can also act as a <Flex /> component when the
   * size parameter is passed
   *
   * Examples
   *
   * ```html
   * <Layout>
   *   <Flex /><Flex /><Flex />
   * </Layout>
   * ```
   *
   * Defaults to a row layout with 'start stretch' alignment
   *
   * ```
   * |[   ][   ][   ]|
   * |[ 1 ][ 2 ][ 3 ]|
   * |[   ][   ][   ]|
   * ```
   *
   * ---
   *
   * ```html
   * <Layout direction="column">
   *   <Flex /><Flex /><Flex />
   * </Layout>
   * ```
   *
   * ```
   * |[   1   ]|
   * |[   2   ]|
   * |[   3   ]|
   * ```
   *
   * ---
   *
   * ```html
   * <Layout align="center center">
   *   <Flex /><Flex /><Flex />
   * </Layout>
   * ```
   *
   * ```
   * |               |
   * |   [1][2][3]   |
   * |               |
   * ```
   *
   * ---
   *
   * ```html
   * <Layout align="space-between center">
   *   <Flex /><Flex /><Flex />
   * </Layout>
   * ```
   *
   * ```
   * |               |
   * | [1]  [2]  [3] |
   * |               |
   * ```
-}


type Alignment
    = Start
    | Center
    | End'
    | SpaceAround
    | SpaceBetween
    | Stretch


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
    String.concat [ "Flex-", size ]


parseOrder : String -> String
parseOrder order =
    String.concat [ "FlexOrder-", order ]


type alias LayoutParams =
    { align : Maybe String
    , direction : Maybe String
    , reverse : Maybe Bool
    , size : Maybe String
    , order : Maybe String
    , wrap : Maybe Bool
    , fill : Maybe Bool
    }


layout : LayoutParams -> Html b -> Html b
layout params children =
    let
        size =
            parseSize (Maybe.withDefault "100" params.size)

        -- Get alignment
        aligns =
            Array.fromList (String.split " " (Maybe.withDefault "start stretch" params.align))

        parallel =
            toAlignment (String.toLower (Maybe.withDefault "start" (Array.get 0 aligns)))

        perpendicular =
            toAlignment (String.toLower (Maybe.withDefault "stretch" (Array.get 1 aligns)))

        direction =
            parseDirection (Maybe.withDefault "row" params.direction) (Maybe.withDefault False params.reverse)

        order =
            parseOrder (Maybe.withDefault "1" params.order)

        wrap =
            Maybe.withDefault True params.wrap

        fill =
            Maybe.withDefault False params.fill

        classes =
            [ ( size, True )
            , ( direction, True )
            , ( getAlignment "parallel" parallel, True )
            , ( getAlignment "perpendicular" perpendicular, True )
            , ( order, True )
            , ( toString Wrap, wrap )
            , ( toString Fill, fill )
            ]
    in
        div [ classList classes ]
            [ children
            ]

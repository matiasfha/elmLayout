module Grid exposing (css, CssClasses(..), styleNamespace)

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import String exposing (concat)


styleNamespace : Html.CssHelpers.Namespace String a b c
styleNamespace =
    withNamespace "elm-layout-"


type CssClasses
    = Layout
    | Wrap
    | Fill
    | Flex
    | FlexInitial
    | AlignParallelStart
    | AlignParallelCenter
    | AlignParallelEnd
    | AlignParallelSpaceAround
    | AlignParallelSpaceBetween
    | AlignPerpendicularStart
    | AlignPerpendicularCenter
    | AlignPerpendicularEnd
    | AlignPerpendicularStretch
    | LayoutRow
    | LayoutRowReverse
    | LayoutColumn
    | LayoutColumnReverse
    | Container


size : String -> List Snippet
size name =
    case String.toFloat name of
        Err msg ->
            []

        Ok size ->
            [ (.) LayoutRow
                [ children
                    [ (.) (concat [ (toString Flex), "-", name ])
                        [ maxWidth (px size)
                        , maxHeight (pct 100)
                        ]
                    ]
                ]
            , (.) LayoutColumn
                [ children
                    [ (.) (concat [ (toString Flex), "-", name ])
                        [ maxHeight (px size)
                        , maxWidth (pct 100)
                        ]
                    ]
                ]
            , (.) (concat [ (toString Flex), "-", name ])
                [ boxSizing borderBox
                , flex3 (int 1) (int 1) (px size)
                ]
            ]


type AutoOrSize
    = Auto
    | Percent Float


dimesion : String -> AutoOrSize -> Maybe Int -> Maybe Int -> List Snippet
dimesion name size grow shrink =
    let
        gr =
            Maybe.withDefault 1 grow

        shr =
            Maybe.withDefault 1 shrink
    in
        case size of
            Auto ->
                [ selector (concat [ styleNamespace.name, (toString Flex), "-", name ])
                    [ boxSizing borderBox
                    , flex2 (int gr) (int shr)
                    ]
                ]

            Percent value ->
                [ selector (concat [ styleNamespace.name, (toString Flex), "-", name ])
                    [ boxSizing borderBox
                    , flex3 (int gr) (int shr) (pct value)
                    ]
                ]


layout : Mixin
layout =
    mixin
        [ displayFlex
        , boxSizing borderBox
        ]


flexMixin : Mixin
flexMixin =
    mixin
        [ boxSizing borderBox
        ]


flexOrder : Int -> List Snippet
flexOrder value =
    let
        val =
            toString value
    in
        [ (.) (concat [ ".FlexOrder-", val ])
            [ order (int value)
            ]
        ]


baseCss : List Snippet
baseCss =
    [ (.) Layout
        [ layout
        ]
    , (.) Wrap
        [ flexWrap wrap
        ]
    , (.) Fill
        [ position relative
        , width (pct 100)
        , height (pct 100)
        ]
    , (.) Flex
        [ flexMixin
        ]
    , (.) FlexInitial
        [ flexMixin
        , flex (int 1)
        ]
    , (.) AlignParallelStart
        [ property "justify-content" "flext-start"
        ]
    , (.) AlignParallelCenter
        [ property "justify-content" "center" ]
    , (.) AlignParallelEnd
        [ property "justify-content" "flext-end" ]
    , (.) AlignParallelSpaceAround
        [ property "justify-content" "space-around" ]
    , (.) AlignParallelSpaceBetween
        [ property "justify-content" "space-between" ]
    , (.) AlignPerpendicularStart
        [ property "align-content" "flex-start"
        , alignItems flexStart
        ]
    , (.) AlignPerpendicularCenter
        [ property "align-content" "center"
        , alignItems center
        ]
    , (.) AlignPerpendicularEnd
        [ property "align-content" "flex-end"
        , alignItems flexEnd
        ]
    , (.) AlignPerpendicularStretch
        [ property "align-content" "stretch"
        , alignItems stretch
        ]
    , (.) LayoutRow
        [ layout
        , flexDirection row
        ]
    , (.) LayoutRowReverse
        [ layout
        , flexDirection rowReverse
        ]
    , (.) LayoutColumn
        [ layout
        , flexDirection column
        ]
    , (.) LayoutColumnReverse
        [ layout
        , flexDirection columnReverse
        ]
    , (.) Container
        [ position relative
        , children
            [ selector ".layout"
                [ width (pct 100)
                , position absolute
                ]
            ]
        ]
    ]


mergedCss : List Snippet
mergedCss =
    let
        sizesList =
            List.concatMap size [ "0", "5", "10", "15", "20", "25", "30", "35", "40", "45", "50", "55", "60", "65", "70", "75", "80", "85", "90", "95", "100", "33.33", "66.66" ]

        dimesionList =
            List.concat
                [ dimesion "auto" Auto Nothing Nothing
                , dimesion "grow" (Percent 100) Nothing Nothing
                , dimesion "nogrow" (Percent 0) (Just 0) (Just 1)
                , dimesion "noshrink" Auto (Just 1) (Just 0)
                ]

        orderList =
            List.concatMap flexOrder [-20..20]
    in
        List.concat [ baseCss, sizesList, dimesionList, orderList ]


css : Stylesheet
css =
    (stylesheet << namespace styleNamespace.name)
        mergedCss

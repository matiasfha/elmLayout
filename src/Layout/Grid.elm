module Layout.Grid exposing (css, CssClasses(..), styleNamespace)

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
    | NoWrap
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
    | FlexOrder Int
    | FlexSize String


size : String -> List Snippet
size name =
    case String.toFloat name of
        Err msg ->
            []

        Ok size ->
            [ (.) LayoutRow
                [ children
                    [ (.) (FlexSize name)
                        [ maxWidth (pct size)
                        , maxHeight (pct 100)
                        ]
                    ]
                ]
            , (.) LayoutColumn
                [ children
                    [ (.) (FlexSize name)
                        [ maxHeight (pct size)
                        , maxWidth (pct 100)
                        , width (pct size)
                        ]
                    ]
                ]
            , (.) (FlexSize name)
                [ boxSizing borderBox
                , flex3 (int 1) (int 1) (pct size)
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
                [ (.) (FlexSize name)
                    [ boxSizing borderBox
                      -- , flex3 (int gr) (int shr) auto
                    , property "flex" "1 0 auto"
                    ]
                ]

            Percent value ->
                [ (.) (FlexSize name)
                    [ boxSizing borderBox
                    , flex3 (int gr) (int shr) (pct value)
                    ]
                ]


layoutMixin : Mixin
layoutMixin =
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
    [ (.) (FlexOrder value)
        [ order (int value)
        ]
    ]


justifyContent : String -> Mixin
justifyContent str =
    property "justify-content" str


alignContent : String -> Mixin
alignContent str =
    property "align-content" str


baseCss : List Snippet
baseCss =
    [ selector "body"
        [ boxSizing borderBox
        , padding zero
        , margin zero
        ]
    , (.) Layout
        [ layoutMixin
        ]
    , (.) Wrap
        [ flexWrap wrap
        ]
    , (.) NoWrap
        [ flexWrap noWrap ]
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
        [ justifyContent "flex-start"
        ]
    , (.) AlignParallelCenter
        [ justifyContent "center" ]
    , (.) AlignParallelEnd
        [ justifyContent "flex-end" ]
    , (.) AlignParallelSpaceAround
        [ justifyContent "space-around" ]
    , (.) AlignParallelSpaceBetween
        [ justifyContent "space-between" ]
    , (.) AlignPerpendicularStart
        [ alignContent "flex-start"
        , alignItems flexStart
        ]
    , (.) AlignPerpendicularCenter
        [ alignContent "center"
        , alignItems center
        ]
    , (.) AlignPerpendicularEnd
        [ alignContent "flex-end"
        , alignItems flexEnd
        ]
    , (.) AlignPerpendicularStretch
        [ alignContent "stretch"
        , alignItems stretch
        ]
    , (.) LayoutRow
        [ layoutMixin
        , flexDirection row
        ]
    , (.) LayoutRowReverse
        [ layoutMixin
        , flexDirection rowReverse
        ]
    , (.) LayoutColumn
        [ layoutMixin
        , flexDirection column
        ]
    , (.) LayoutColumnReverse
        [ layoutMixin
        , flexDirection columnReverse
        ]
    , (.) Container
        [ position relative
        , children
            [ (.) Layout
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

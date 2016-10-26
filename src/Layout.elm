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

{-
   * The <layout /> element works as the container of many child flexboxes.
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

import Html exposing (..)
import Layout.Grid exposing (styleNamespace)
import Layout.Helpers exposing (..)
import Layout.Attributes as Attr exposing (..)


{ id, class, classList, name } =
    styleNamespace
layout : List LAttr -> List (Html msg) -> Html msg
layout params children =
    node "layout" (getClassList params) children



{-
   * The <Flex /> element serves as both a column and a row, depending on its
   * <Layout /> direction.
   * Both the size and order parameters can take the form of a number or an object
   * if a media query needs to be specified.
   * The supported queries are:
   * - mobile
   * - small
   * - medium
   * - large
   * - the `>` operator, which means greater than (`> small`)
   *
   * Examples
   *
   * ```
   * // first on mobile, second on small and third on greater than small resolutions
   * <Flex order={{
   *   'mobile': 0,
   *   'small': 1,
   *   '> small': 2
   * }} />
   * // first on greater than small, second on mobile and third on small resolutions
   * <Flex order={{
   *   'mobile': 1,
   *   'small': 2,
   *   '> small': 0
   * }} />
   * // first on small, second on greater than small and third on mobile resolutions
   * <Flex order={{
   *   'mobile': 2,
   *   'small': 0,
   *   '> small': 1
   * }} />
   * ```
   *
   * ```
   * <Flex size={{
   *   'mobile': 50,
   *   'small': 30,
   *   '> small': 20
   * }} />
   * <Flex size="100">
   * ```
-}


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
    let
        innerParams =
            [ fill True ]

        -- params :: [ fill True ]
    in
        layout
            [ wrap False, fill True ]
            [ (layout innerParams (children))
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

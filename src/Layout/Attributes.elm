module Layout.Attributes exposing (..)

import Layout.Helpers exposing (..)
import Layout.Types exposing (..)


alignPerpen : String -> LAttr
alignPerpen str =
    let
        aligns =
            parseAlign ("-- " ++ str)
    in
        { value = aligns.perpendicular, active = True }


alignPara : String -> LAttr
alignPara str =
    let
        aligns =
            parseAlign (str ++ " --")
    in
        { value = aligns.parallel, active = True }


size : String -> LAttr
size str =
    { value = parseSize str, active = True }


direction : ( Direction, Bool ) -> LAttr
direction ( direction, reverse ) =
    { value = parseDirection direction reverse, active = True }


fill : Bool -> LAttr
fill bool =
    { value = parseFill bool, active = bool }


wrap : Bool -> LAttr
wrap bool =
    { value = parseWrap bool, active = True }


order : Int -> LAttr
order number =
    { value = parseOrder number, active = True }

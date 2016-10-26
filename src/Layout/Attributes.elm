module Layout.Attributes exposing (..)

import Layout.Helpers exposing (..)


type alias LAttr =
    { value : String
    , active : Bool
    }


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


direction : ( String, Bool ) -> LAttr
direction ( str, reverse ) =
    { value = parseDirection str reverse, active = True }


fill : Bool -> LAttr
fill bool =
    { value = parseFill bool, active = bool }


wrap : Bool -> LAttr
wrap bool =
    { value = parseWrap bool, active = True }


order : Int -> LAttr
order number =
    { value = parseOrder number, active = True }

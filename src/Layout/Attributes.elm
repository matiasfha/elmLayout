module Layout.Attributes exposing (..)

import Layout.Helpers exposing (..)
import Layout.Types exposing (..)


alignPerpen : Alignment -> LAttr
alignPerpen str =
    { value = toString str, active = True }


alignPara : Alignment -> LAttr
alignPara str =
    { value = toString str, active = True }


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

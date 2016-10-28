module Layout.Types exposing (LAttr, Alignment(..), Direction(..))


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


type Direction
    = Row
    | Column

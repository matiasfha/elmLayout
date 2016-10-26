port module Stylesheets exposing (..)

import Layout.Grid exposing (..)


-- To create a css file

import Html.App as Html
import Html exposing (div)
import Css.File exposing (..)


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure [ ( "style.css", Css.File.compile [ css ] ) ]


main : Program Never
main =
    Html.program
        { init = ( (), files cssFiles )
        , view = \_ -> (div [] [])
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }

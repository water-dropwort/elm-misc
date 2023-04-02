module SvgTest exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Svg as S exposing (Svg)
import Svg.Attributes as SA
import SquareArray2D as A2D exposing (SquareArray2D)
import Array exposing (Array)

main : Program () Model Msg
main = Browser.sandbox
       { init = init
       , update = update
       , view = view
       }

type alias Model = SquareArray2D Int

type Msg = Update

init : Model
init = A2D.initialize 3 (\i j -> modBy 3 (i * j))

update : Msg -> Model -> Model
update _ model = A2D.map (\x -> modBy 3 (x+1)) model

cellSize = 30

viewCells : Model -> Html Msg
viewCells model = S.svg [] (toFlatList (A2D.indexedMap toRect model))

toFlatList : SquareArray2D a -> List a
toFlatList array = Array.toList (A2D.toFlatArrayRowMajor array)

translate : Int -> Int -> String
translate i j = String.concat [ "translate("
                              , String.fromInt (i * cellSize)
                              , ","
                              , String.fromInt (j * cellSize)
                              ,")"]

color : Int -> String
color x = case x of
              0 -> "blue"
              1 -> "green"
              2 -> "yellow"
              _ -> "black"

toRect : Int -> Int -> Int -> Svg Msg
toRect i j x = S.rect [ SA.transform (translate i j)
                      , SA.fill (color x)
                      , SA.width (String.fromInt cellSize)
                      , SA.height (String.fromInt cellSize)
                      , SA.stroke "gray"
                      , SA.strokeWidth "1"] []

view : Model -> Html Msg
view model = div [] [ button [onClick Update] [text "UPDATE"]
                    , div [] [viewCells model]
                    ]

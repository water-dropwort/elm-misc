module TimerTest exposing (main)

import Browser
import Html exposing (Html, text, div)
import Task
import Time
import Svg as S
import Svg.Attributes as SA

type Model = Red | Green | Blue

type Msg = Tick Time.Posix

main : Program () Model Msg
main = Browser.element
       { init = init
       , update = update
       , view = view
       , subscriptions = subscriptions
       }

init : () -> (Model, Cmd Msg)
init _ = (Red, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update _ model =
    case model of
        Red   -> (Green, Cmd.none)
        Green -> (Blue,  Cmd.none)
        Blue  -> (Red,   Cmd.none)

model2String : Model -> String
model2String model =
    case model of
        Red   -> "red"
        Green -> "green"
        Blue  -> "blue"

view : Model -> Html Msg
view model = div [] [ div [] [text (model2String model)]
                    , S.svg [] [
                           S.rect [ SA.fill (model2String model)
                                  , SA.width "30"
                                  , SA.height "30"
                                  ] []
                          ]
                    ]

subscriptions : Model -> Sub Msg
subscriptions _ = Time.every 500 Tick

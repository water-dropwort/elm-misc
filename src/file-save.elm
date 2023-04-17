module FileSave exposing (..)

import Browser
import File.Download as DL
import Html exposing (Html, div, text, button, input)
import Html.Events exposing (onClick)

main : Program () Model Msg
main =
    Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

type alias Model = ()

init : () -> (Model, Cmd Msg)
init _ = ((), Cmd.none)

type Msg
    = Download

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Download ->
            (model, DL.string "text.txt" "text/plain" "ほげ")

view : Model -> Html Msg
view model =
    div
        []
        [ button
              [ onClick Download ]
              [ text "Click"]
        ]

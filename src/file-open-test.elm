module FileOpenTest exposing (..)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Task
import File exposing (File)
import File.Select as Select

main : Program () Model Msg
main =
    Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

type alias Model = String
init : () -> (Model, Cmd Msg)
init _ = ("", Cmd.none)


type Msg
    = FileRequested
    | FileSelected File
    | FileLoaded String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FileRequested ->
            (model, Select.file ["text/plain"] FileSelected)
        FileSelected file ->
            (model, Task.perform FileLoaded (File.toString file))
        FileLoaded content ->
            (content, Cmd.none)

view : Model -> Html Msg
view model =
    div
        []
        [ button
              [ onClick FileRequested ]
              [ text "Open text" ]
        , div
              []
              [ text model ]
        ]

module KeyEventTest exposing (main)

import Browser
import Browser.Events
import Html exposing (Html, Attribute, div, text)
import Html.Events exposing (on, keyCode)
import Json.Decode as Decode

main : Program () Model Msg
main = Browser.element
       { init = init
       , update = update
       , view = view
       , subscriptions = subscriptions
       }

type alias Model = Int

init :() -> (Model, Cmd Msg)
init _ = (0, Cmd.none)

type Msg = Enter Key

type Key = ArrowUp | ArrowDown | Other

update : Msg -> Model -> (Model, Cmd Msg)
update (Enter key) model =
    case key of
        ArrowUp   -> (model + 1, Cmd.none)
        ArrowDown -> (model - 1, Cmd.none)
        _         -> (model, Cmd.none)

onKeyDown : Attribute Msg
onKeyDown = on "keydown" keyDecoder

keyDecoder : Decode.Decoder Msg
keyDecoder = Decode.map toKey (Decode.field "key" Decode.string)

view : Model -> Html Msg
view model =
    div [onKeyDown] [ div [] [text "↑:Increment,↓:Decrement"]
                    , text (String.fromInt model)]

subscriptions : Model -> Sub Msg
subscriptions _ = Browser.Events.onKeyDown keyDecoder

toKey : String -> Msg
toKey key =
    case key of
        "ArrowUp"   -> Enter ArrowUp
        "ArrowDown" -> Enter ArrowDown
        _           -> Enter Other

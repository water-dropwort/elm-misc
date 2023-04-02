module ShadowingTest exposing (main)

import Html exposing (..)

main = text (showName "Mike")

name = "Tom"
showName name = "My name is " ++ name

module SimpleWebPage exposing (main)

import Html exposing (..)

chapter1 = section [] [ h1 [] [ text "1.Overview"]
                      , p  [] [ text "This article allows you to ..."]
                      ]

chapter2 = section [] [ h1 [] [ text "2.Tutorial"]
                      , h2 [] [ text "2.1.Instllation"]
                      , ol [] [ li [] [ text "Download installer from ..."]
                              , li [] [ text "Execute installer ..."]
                              ]
                      , h2 [] [ text "2.2.Create your first project"]
                      , p  [] [ text "Open cmd.exe and run command ..."]
                      ]
main = article [] [chapter1, chapter2]

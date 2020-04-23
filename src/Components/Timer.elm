module Components.Timer exposing (view)

import Element exposing (..)
import Element.Font as Fonts
import Html.Attributes as Html
import Time


view : Time.Posix -> ( Int, Time.Posix ) -> Element msg
view now ( offset, start ) =
    let
        elapsed =
            Time.posixToMillis now - Time.posixToMillis start + offset

        ms =
            modBy 1000 elapsed

        s =
            modBy 60 (elapsed // 1000)

        m =
            modBy 60 (elapsed // (60 * 1000))

        h =
            elapsed // (60 * 60 * 1000)

        p n i =
            String.fromInt i
                |> String.padLeft n '0'
    in
    paragraph
        [ padding 10
        , Fonts.center
        , Fonts.size 50
        , Fonts.bold
        , Fonts.color <| rgba 1 1 1 0.9
        ]
        [ el
            [ onRight
                (el
                    [ alpha <|
                        if m <= 0 then
                            1.0

                        else
                            0.2
                    , htmlAttribute (Html.style "transition" "opacity 1.5s")
                    , Fonts.size 30
                    , moveDown 17
                    ]
                    (Element.text (":" ++ p 2 s ++ "." ++ p 3 ms))
                )
            ]
            (Element.text (p 2 h ++ ":" ++ p 2 m))
        ]

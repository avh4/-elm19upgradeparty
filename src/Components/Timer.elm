module Components.Timer exposing (stringMS, view)

import Element exposing (..)
import Element.Font as Fonts
import Html.Attributes as Html
import Time


stringMS : Time.Posix -> ( Int, Time.Posix ) -> String
stringMS now ( offset, start ) =
    let
        elapsed =
            Time.posixToMillis now - Time.posixToMillis start + offset

        s =
            modBy 60 (elapsed // 1000)

        m =
            elapsed // (60 * 1000)

        p n i =
            String.fromInt i
                |> String.padLeft n '0'
    in
    p 2 m ++ ":" ++ p 2 s


view : Time.Posix -> ( Int, Maybe Time.Posix ) -> Element msg
view now ( offset, start ) =
    let
        elapsedSinceLatestStart =
            case start of
                Nothing ->
                    0

                Just start_ ->
                    Time.posixToMillis now - Time.posixToMillis start_

        elapsed =
            offset + elapsedSinceLatestStart

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
        [ Fonts.center
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
                    , centerY
                    , moveDown 8
                    ]
                    (Element.text (":" ++ p 2 s ++ "." ++ p 3 ms))
                )
            , onLeft <|
                if start == Nothing then
                    el
                        [ Fonts.size 30
                        , centerY
                        , padding 10
                        , moveDown 2
                        ]
                        (text "⏸")

                else
                    none
            ]
            (Element.text (p 2 h ++ ":" ++ p 2 m))
        ]

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


type alias Timer =
    ( Int, Maybe Time.Posix )


timerToHMS : Time.Posix -> Timer -> { h : Int, m : Int, s : Int, isPaused : Bool }
timerToHMS now timer =
    let
        ( offset, start ) =
            timer

        elapsedSinceLatestStart =
            case start of
                Nothing ->
                    0

                Just start_ ->
                    Time.posixToMillis now - Time.posixToMillis start_

        elapsed =
            offset + elapsedSinceLatestStart
    in
    { h = elapsed // (60 * 60 * 1000)
    , m = modBy 60 (elapsed // (60 * 1000))
    , s = modBy 60 (elapsed // 1000)
    , isPaused = start == Nothing
    }


view : Time.Posix -> Timer -> Element msg
view now timer =
    let
        { h, m, s, isPaused } =
            timerToHMS now timer

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
                            0.3
                    , htmlAttribute (Html.style "transition" "opacity 1.5s")
                    , Fonts.size 30
                    , centerY
                    , moveDown 8
                    ]
                    (Element.text (":" ++ p 2 s))
                )
            , onLeft <|
                if isPaused then
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

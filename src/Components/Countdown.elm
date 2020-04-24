module Components.Countdown exposing (view)

import Element exposing (..)
import Element.Font as Fonts
import Html.Attributes
import Time


view : Time.Posix -> Time.Posix -> Element msg
view now done =
    let
        remaining =
            Time.posixToMillis done - Time.posixToMillis now

        s =
            modBy 60 (remaining // 1000)

        m =
            remaining // (60 * 1000)

        p n i =
            String.fromInt i
                |> String.padLeft n '0'

        ( fontSize, message ) =
            if remaining > 0 then
                ( 80, String.fromInt m ++ ":" ++ p 2 s )

            else if remaining > -(3 * 60 * 1000) then
                -- if it's less than 5 minutes since the end of the countdown
                ( 45, "Starting imminently!" )

            else
                ( 45, "" )
    in
    paragraph
        [ padding 10
        , Fonts.center
        , Fonts.size fontSize
        , Fonts.bold
        , Fonts.color <| rgb 1 1 1
        , htmlAttribute (Html.Attributes.class "pinkGlow")
        ]
        [ text message
        ]

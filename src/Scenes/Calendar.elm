module Scenes.Calendar exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html
import Html.Attributes
import Palette


data : List Day
data =
    [ { day = "Tue, July 14"
      , events =
            [ OtherEvent
                { time = "9:30am PDT"
                , startHour = 9.5
                , duration = 1.5
                , text = "Sarah Drasner on Learn With Jason \"Make Animations Feel Pro\""
                }
            , MyEvent
                { time = "11am PDT"
                , time2 = " / 5pm UTC"
                , startHour = 11
                , duration = 2
                , title = "Elm Game Jam 4 review (part 2)"
                , description = "playing the games, and taking a look at the code"
                }
            ]
      }
    , { day = "Wed, July 15"
      , events =
            [ MyEvent
                { time = "11am PDT"
                , time2 = " / 5pm UTC"
                , startHour = 11
                , duration = 2
                , title = "elm-program-test with @mikethadley"
                , description = "we'll be adding some advanced effect simulation features to elm-program-test"
                }
            ]
      }
    , { day = "Thu, July 16"
      , events =
            [ MyEvent
                { time = "11am PDT"
                , time2 = " / 5pm UTC"
                , startHour = 11
                , duration = 2
                , title = "FLIP animations with elm-animator"
                , description = "making a reusable module for arbitrary page transition animations"
                }
            , MyEvent
                { time = "2pm PDT"
                , time2 = " / 8pm UTC"
                , startHour = 14
                , duration = 1
                , title = "stream overlays in Elm"
                , description = ""
                }
            , OtherEvent
                { time = "6pm EDT"
                , startHour = 15
                , duration = 2
                , text = "ChaelCodes plays Exapunks"
                }
            ]
      }
    , { day = "Fri, July 17"
      , events =
            [ MyEvent
                { time = "11am PDT"
                , time2 = " / 5pm UTC"
                , startHour = 11
                , duration = 2
                , title = "Getting elm-format to 1.0"
                , description = "[haskell] adding multiline support to types"
                }
            ]
      }
    , { day = "Sat, July 18"
      , events =
            [ MyEvent
                { time = "10am PDT"
                , time2 = " / 4pm UTC"
                , startHour = 10
                , duration = 2.5
                , title = "Test-Driven Development with Elm"
                , description = "continuing our “Recipe Science!” mobile-first webapp"
                }
            ]
      }
    ]


view : Element msg
view =
    if True then
        row
            [ height fill
            ]
            (List.map viewDay data)

    else
        html (Html.textarea [ Html.Attributes.style "height" "400px" ] [ Html.text asString ])


asString : String
asString =
    let
        renderDay day =
            List.map (renderEvent day) day.events

        renderEvent day e =
            case e of
                MyEvent event ->
                    "- " ++ day.day ++ ", " ++ event.time ++ event.time2 ++ ": " ++ event.title ++ " — " ++ event.description

                OtherEvent event ->
                    "- " ++ day.day ++ ", " ++ event.time ++ ": " ++ event.text
    in
    "Upcoming stream schedule:\n"
        ++ (data
                |> List.concatMap renderDay
                |> String.join "\n"
           )


type alias Day =
    { day : String
    , events : List Event
    }


type Event
    = MyEvent
        { time : String
        , time2 : String
        , startHour : Float
        , duration : Float
        , title : String
        , description : String
        }
    | OtherEvent
        { time : String
        , startHour : Float
        , duration : Float
        , text : String
        }


viewDay : Day -> Element msg
viewDay day =
    let
        dayWidth =
            245
    in
    column
        [ width (px dayWidth)
        , height fill
        , Border.color (rgb 0.5 0.5 0.5)
        , Border.widthXY 1 0
        , Border.dotted
        , padding 10
        ]
        [ el [ height (px 20) ] none
        , el
            [ Font.color Palette.color.mainText
            , Font.extraBold
            , alpha 0.8
            , Font.size 21
            ]
            (text day.day)
        , viewEvents day
        ]


hourSize =
    98


viewEvents : Day -> Element msg
viewEvents day =
    case List.map (viewEvent day) day.events of
        [] ->
            el
                [ Font.color Palette.color.mainText
                , alpha 0.4
                , Font.size 20
                , height (px <| hourSize * 5)
                , width fill
                ]
                (paragraph
                    [ centerX
                    , centerY
                    , Font.center
                    ]
                    [ text "No stream today" ]
                )

        first :: rest ->
            List.foldl
                (\next stack ->
                    el
                        [ width fill
                        , behindContent stack
                        ]
                        next
                )
                first
                rest


viewEvent day e =
    let
        hourAtTop =
            9.2

        moveDownForStart startHour =
            moveDown (hourSize * (startHour - hourAtTop))

        heightForDuration duration =
            height (px (round (hourSize * duration) - 10))

        isToday =
            day.day == "Fri, July 10"

        theme =
            if isToday then
                { borderColor = Palette.color.accentBold
                , startTimeColor = Palette.color.accentBold
                , gradientAngle = degrees 140
                }

            else
                { borderColor = rgb 0.6 0.7 0.67
                , startTimeColor = Palette.color.accent
                , gradientAngle = degrees 140
                }
    in
    case e of
        MyEvent event ->
            el
                [ Background.gradient
                    { angle = theme.gradientAngle
                    , steps =
                        [ Palette.color.bgGradientBlue
                        , Palette.color.bgGradientGreen
                        ]
                    }
                , Font.color Palette.color.mainText
                , width fill
                , Border.rounded 11
                , Border.color theme.borderColor
                , Border.width 3
                , padding 10
                , moveDownForStart event.startHour
                , heightForDuration event.duration
                ]
                (column
                    [ spacing 7
                    ]
                    [ row
                        [ Font.size 13
                        ]
                        [ el
                            [ Font.extraBold
                            , Font.color theme.startTimeColor
                            ]
                            (text event.time)
                        , text event.time2
                        ]
                    , paragraph
                        [ spacing 2
                        , Font.size 22
                        ]
                        [ text event.title
                        ]
                    , paragraph
                        [ spacing 1
                        , Font.size 16
                        , alpha 0.8
                        ]
                        [ text event.description
                        ]
                    ]
                )

        OtherEvent event ->
            el
                [ Font.color Palette.color.mainText
                , width fill
                , Border.rounded 11
                , Border.color theme.borderColor
                , Border.width 2
                , padding 10
                , moveDownForStart event.startHour
                , heightForDuration event.duration
                , alpha 0.7
                ]
                (column
                    [ spacing 5
                    ]
                    [ el
                        [ Font.size 13
                        , Font.bold
                        ]
                        (text event.time)
                    , paragraph
                        [ spacing 1
                        , Font.size 14
                        , alpha 0.8
                        ]
                        [ text event.text
                        ]
                    ]
                )

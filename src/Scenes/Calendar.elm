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
    [ { day = "Tue, July 7"
      , events = []
      }
    , { day = "Wed, July 8"
      , events =
            [ { time = "11am PDT"
              , time2 = " / 5pm UTC"
              , startHour = 11
              , duration = 2
              , title = "Elm Game Jam 4 review"
              , description = "playing the games, and taking a look at the code"
              }
            ]
      }
    , { day = "Thu, July 9"
      , events =
            [ { time = "11am PDT"
              , time2 = " / 5pm UTC"
              , startHour = 11
              , duration = 2
              , title = "FLIP animations with elm-animator"
              , description = "making a reusable module for arbitrary page transition animations"
              }
            ]
      }
    , { day = "Fri, July 10"
      , events =
            [ { time = "11am PDT"
              , time2 = " / 5pm UTC"
              , startHour = 11
              , duration = 2
              , title = "Casual Elm Friday"
              , description = "AMA, code review sessions for viewers, and adding features to my stream overlays"
              }
            ]
      }
    , { day = "Sat, July 11"
      , events =
            [ { time = "10am PDT"
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

        renderEvent day event =
            "- " ++ day.day ++ ", " ++ event.time ++ event.time2 ++ ": " ++ event.title ++ " — " ++ event.description
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


type alias Event =
    { time : String
    , time2 : String
    , startHour : Float
    , duration : Float
    , title : String
    , description : String
    }


viewDay : Day -> Element msg
viewDay day =
    let
        dayWidth =
            220
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


viewEvents : Day -> Element msg
viewEvents day =
    let
        hourAtTop =
            8.5

        hourSize =
            95

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
    case day.events of
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

        [ event ] ->
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
                , moveDown (hourSize * (event.startHour - hourAtTop))
                , height (px <| round <| hourSize * event.duration)
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

        _ ->
            text "TODO: multiple streams in a day"

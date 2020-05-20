module Data exposing (Data, Schedule, ScheduleItem, data)

{-| The data about the stream that is used by all scenes.
-}

import Charities
import Components.Timer exposing (Timer)
import Data.Timer
import Music
import Time exposing (Weekday(..))


data : Data
data =
    { title = "Learning elm-animator"
    , summary = Just "Based on Sarah Drasner's \"The Future of Web Animation\""
    , startAt = Time.millisToPosix 1589940352000
    , goals = []
    , schedule =
        { past =
            []
        , upcoming =
            [ ScheduleItem (Just "6pm PDT") "Get our reference sdras/page-transitions-travelapp running locally"
            , ScheduleItem Nothing "Set up a SPA app in Elm"
            , ScheduleItem Nothing "Build two of the header layouts with elm-ui"
            , ScheduleItem Nothing "Animate the page transition using FLIP principles"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Sat
            , title = "Test-driven development with Elm (part 7)"
            }
    , timer = Data.Timer.timer
    , charity = Nothing
    , music = Just Music.adhesiveWombat
    , links =
        [ -- "https://refactoringui.com/book/"
          "https://github.com/sdras/page-transitions-travelapp"
        , "https://css-tricks.com/animating-layouts-with-the-flip-technique/"
        , "https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/"
        , "https://package.elm-lang.org/packages/mdgriffith/elm-animator/latest/"
        ]
    }


regularTime : Time.Weekday -> String
regularTime day =
    case day of
        Tue ->
            "Tue 6pm PDT / Wed 1am UTC"

        Sat ->
            "Sat 9am PDT / 4pm UTC"

        _ ->
            ""


type alias Data =
    { title : String
    , summary : Maybe String
    , startAt : Time.Posix
    , goals : List ( String, Time.Posix )
    , schedule : Schedule
    , nextStream :
        Maybe
            { time : String
            , title : String
            }
    , timer : Maybe Timer
    , charity : Maybe Charities.CharityInfo
    , music : Maybe Music.MusicInfo
    , links : List String
    }


type alias Schedule =
    { past : List ScheduleItem
    , upcoming : List ScheduleItem
    }


type alias ScheduleItem =
    { time : Maybe String
    , description : String
    }

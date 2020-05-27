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
    { title = "Making fancy animations in Elm"
    , summary = Just "(with intermittent attempts to diagnose my laggy laptop)"
    , startAt = Time.millisToPosix 1590541519000
    , goals = []
    , schedule =
        { past =
            []
        , upcoming =
            [ ScheduleItem Nothing "generalize our code for animating arbitrary page layout changes"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Sat
            , title = "Test-driven development with Elm"
            }
    , timer = Data.Timer.timer
    , charity = Nothing
    , music = Just Music.ericSkiff
    , links =
        [-- "https://refactoringui.com/book/"
         --  "https://github.com/sdras/page-transitions-travelapp"
         --, "https://css-tricks.com/animating-layouts-with-the-flip-technique/"
         --, "https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/"
         --, "https://package.elm-lang.org/packages/mdgriffith/elm-animator/latest/"
         --  "https://avlive.gitlab.io/hafns"
         --, "https://itch.io/jam/elm-game-jam-4"
         --, "https://www.inkandswitch.com/local-first.html"
         --, "https://elm-radio.com/episode/elm-parser/"
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

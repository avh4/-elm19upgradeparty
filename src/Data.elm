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
    { title = "Test-driven development in Elm"
    , summary = Just "trying to work fast today; please ask if you want something explained better 🙂"
    , startAt = Time.millisToPosix 1589644839000
    , goals = []
    , schedule =
        { past =
            []
        , upcoming =
            [ ScheduleItem (Just "9am PDT") "Let's get to work!"
            , ScheduleItem Nothing "finish feature: scaling a recipe to a certain amount"
            , ScheduleItem Nothing "new feature: ingredients are in the correct order"
            , ScheduleItem Nothing "new feature: refer back to previous recipes"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Tue
            , title = "Open-source Elm work (specifics TBD)"
            }
    , timer = Data.Timer.timer
    , charity = Nothing
    , music = Just Music.ericSkiff
    , links =
        []
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

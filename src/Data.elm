module Data exposing (Data, Schedule, ScheduleItem, data)

{-| The data about the stream that is used by all scenes.
-}

import Charities
import Music
import Time exposing (Weekday(..))


data : Data
data =
    { title = "Test-driven development with Elm"
    , summary = Nothing
    , startAt = Time.millisToPosix 0
    , goals = []
    , schedule =
        { past =
            []
        , upcoming =
            [ ScheduleItem (Just "6pm PDT") "Demo — what we've deployed so far"

            --, ScheduleItem (Just "9:05 PDT") "Iteration planning — what's our next big goal?"
            , ScheduleItem (Just "6:05 PDT") "Implement our next feature(s)"
            , ScheduleItem (Just "6:55 PDT") "Retrospective"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Sat
            , title = "Test-driven development with Elm (part 5)"
            }
    , timer = Just ( lastTime 7 39 8 0, Nothing )
    , charity = Nothing
    , music = Just Music.adhesiveWombat
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


lastTime h m s ms =
    ((((h * 60) + m) * 60 + s) * 1000) + ms


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
    , timer : Maybe ( Int, Maybe Time.Posix )
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

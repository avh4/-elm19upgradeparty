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
            [ ScheduleItem (Just "9am PDT") "Review our app so far"
            , ScheduleItem (Just "9:05 PDT") "Iteration planning — what are we working toward?"
            , ScheduleItem Nothing "Implement our next feature(s)"
            , ScheduleItem (Just "11:05 PDT") "Retrospective"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Tue
            , title = "Stream layout improvements (in Elm!)"
            }
    , timer = Just ( lastTime 8 44 30 0, Nothing )
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

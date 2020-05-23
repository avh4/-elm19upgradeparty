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
    { title = "Test-driven development with Elm"
    , summary = Nothing
    , startAt = Time.millisToPosix 1589940352000
    , goals = []
    , schedule =
        { past =
            []
        , upcoming =
            [ ScheduleItem Nothing "Adding persistent storage using Elm ports (and testing with elm-program-test)"
            ]
        }
    , nextStream =
        Just
            { time = regularTime Tue
            , title = "Animating page transitions with elm-animator (Part 2)"
            }
    , timer = Data.Timer.timer
    , charity = Nothing
    , music = Just Music.adhesiveWombat
    , links =
        [ -- "https://refactoringui.com/book/"
          --  "https://github.com/sdras/page-transitions-travelapp"
          --, "https://css-tricks.com/animating-layouts-with-the-flip-technique/"
          --, "https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/"
          --, "https://package.elm-lang.org/packages/mdgriffith/elm-animator/latest/"
          "https://avlive.gitlab.io/hafns"
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

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
    { title = "Casual Elm Friday"
    , summary = Just "AMA, viewer code reviews, Elm Q&A, and working on my stream overlays"
    , startAt = Time.millisToPosix 1594404390000
    , goals = []
    , schedule =

        { past =
            [ScheduleItem Nothing "code review of elm-cropper"
                        ,ScheduleItem Nothing "check out wondible's labmda handler"
            , ScheduleItem (Just "11:15am") "taking viewer code review requests — lmk in chat if you're interested"
            , ScheduleItem (Just "(if time)") "improving my stream overlays"
                                     ]
        , upcoming =
            [ ScheduleItem Nothing "AMA + Elm Q&A"
            ]
        }
    , nextStream =
        Just
            { title = "Test-Driven Development with Elm"
            , time = "Sat (tomorrow) 10am PDT / 4pm UTC"
            }
    , timer = Data.Timer.timer
    , charity = Just Charities.blackLivesMatter
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
         --"https://itch.io/jam/elm-game-jam-4"
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

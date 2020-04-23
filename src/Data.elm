module Data exposing (Data, Schedule, ScheduleItem, data)

{-| The data about the stream that is used by all scenes.
-}

import Charities
import Music
import Time


data : Data
data =
    { title = "Learning elm-ui"
    , summary = Nothing
    , schedule =
        { past =
            [ ScheduleItem (Just "6pm PDT") "Alex Korban's elm-ui intro"
            , ScheduleItem Nothing "create a wireframe from mockups"
            ]
        , upcoming =
            [ ScheduleItem Nothing "add styling to the wireframe"
            , ScheduleItem Nothing "learn how to escape to HTML+CSS"
            , ScheduleItem (Just "(if time)") "make a phone+tablet responsive layout"
            , ScheduleItem (Just "(if time)") "try elm-animator"
            ]
        }
    , nextStream =
        Just
            { time = "Sat 9am PDT / 4pm UTC"
            , title = "Test-driven development with Elm (part 1 of ...?)"
            }
    , timer = Nothing
    , charity = Nothing
    , music = Just Music.adhesiveWombat
    , links =
        [ "https://github.com/mdgriffith/elm-ui"
        , "https://korban.net/posts/elm/2019-11-17-elm-ui-introduction/"
        , "https://dribbble.com/shots/5528842-Rainbow-Messenger-App"
        ]
    }


lastTime h m s ms =
    ((((h * 60) + m) * 60 + s) * 1000) + ms


type alias Data =
    { title : String
    , summary : Maybe String
    , schedule : Schedule
    , nextStream :
        Maybe
            { time : String
            , title : String
            }
    , timer : Maybe ( Int, Time.Posix )
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

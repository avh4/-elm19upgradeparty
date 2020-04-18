module Data exposing (Data, Schedule, ScheduleItem, data)

{-| The data about the stream that is used by all scenes.
-}

import Charities


data : Data
data =
    { title = "Welcome Back! Stream setup"
    , summary = Just "hang out, ask anything about Elm while I set up my stream overlays"
    , schedule =
        { past =
            [ ScheduleItem Nothing "Updating scenes (HTML + mustache)"
            ]
        , upcoming =
            [ ScheduleItem Nothing "Experiment with elm-live for OBS scene setup"
            ]
        }
    , charity = Just Charities.blackGirlsCode
    , links =
        [ "https://twitter.com/avh4"
        , "http://www.blackgirlscode.com/"
        , "https://www.elm-live.com/"
        ]
    }


type alias Data =
    { title : String
    , summary : Maybe String
    , schedule : Schedule
    , charity : Maybe Charities.CharityInfo
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

module Scenes.StartingSoon exposing (view)

{-| A scene for before the stream starts.
-}

import Data exposing (Data)
import Html exposing (..)
import ScheduleLayout
import Time


view : Time.Posix -> Data -> Html msg
view =
    ScheduleLayout.view
        { fadeBottom = False
        , sceneTitle = Nothing
        , scheduleTitle = "Today's Schedule"
        , highlightFirst = False
        }

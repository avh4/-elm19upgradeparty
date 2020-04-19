module Scenes.StartingSoon exposing (view)

{-| A scene for before the stream starts.
-}

import Data exposing (Data)
import Html exposing (..)
import ScheduleLayout


view : Data -> Html msg
view =
    ScheduleLayout.view
        { fadeBottom = False
        , sceneTitle = Nothing
        , scheduleTitle = "Today's Schedule"
        , highlightFirst = False
        }

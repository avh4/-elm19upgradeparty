module Scenes.Break exposing (view)

import Data exposing (Data)
import Html exposing (..)
import ScheduleLayout


view : Data -> Html msg
view =
    ScheduleLayout.view
        { fadeBottom = True
        , sceneTitle = Just "On a short break"
        , scheduleTitle = "Up next:"
        , highlightFirst = True
        }

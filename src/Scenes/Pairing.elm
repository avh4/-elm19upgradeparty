module Scenes.Pairing exposing (view)

import Data exposing (Data)
import Html exposing (..)
import ScreenShareLayout


view : Data -> Html msg
view =
    ScreenShareLayout.view
        { showTopCam = True
        , showBottomCam = True
        }

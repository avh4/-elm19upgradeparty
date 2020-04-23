module Scenes.Pairing exposing (view)

import Data exposing (Data)
import Html exposing (..)
import ScreenShareLayout
import Time


view : Time.Posix -> Data -> Html msg
view =
    ScreenShareLayout.view
        { showTopCam = True
        , showBottomCam = True
        }

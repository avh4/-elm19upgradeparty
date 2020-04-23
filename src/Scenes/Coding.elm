module Scenes.Coding exposing (view)

{-| A scene for solo livecoding.
-}

import Data exposing (Data)
import Html exposing (..)
import ScreenShareLayout
import Time


view : Time.Posix -> Data -> Html msg
view =
    ScreenShareLayout.view
        { showTopCam = True
        , showBottomCam = False
        }

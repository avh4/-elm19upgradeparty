module Scenes.Coding exposing (view)

{-| A scene for solo livecoding.
-}

import Data exposing (Data)
import Html exposing (..)
import ScreenShareLayout


view : Data -> Html msg
view =
    ScreenShareLayout.view
        { showTopCam = True
        , showBottomCam = False
        }

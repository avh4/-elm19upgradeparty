module Scenes.Talk exposing (..)

import Data exposing (Data)
import Html exposing (..)
import TalkLayout


view : Data -> Html msg
view =
    TalkLayout.view
        { isGuest = False
        }

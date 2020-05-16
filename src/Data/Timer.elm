module Data.Timer exposing (timer)

import Components.Timer as Timer
import Time


lastTime h m s ms =
    ((((h * 60) + m) * 60 + s) * 1000) + ms


timer =
    Just ( lastTime 8 44 30 0, Nothing )

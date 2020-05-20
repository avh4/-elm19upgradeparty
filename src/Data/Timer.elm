module Data.Timer exposing (timer)

import Components.Timer as Timer
import Time


lastTime h m s ms =
    ((((h * 60) + m) * 60 + s) * 1000) + ms


timer =
    -- TDD project
    --Just ( lastTime 11 34 40 0, Nothing )
    Nothing

module Palette exposing (..)

import Element exposing (..)
import Element.Font as Fonts


color =
    { mainText = rgb 1 1 1
    , accent = rgb255 0xFD 0xBC 0xFF
    , accentBold = rgb255 0xF9 0x57 0xFF
    , bgGradientBlue = rgb255 0x15 0x57 0x99
    , bgGradientGreen = rgb255 0x15 0x99 0x57
    }


fontSize =
    { h1 = Fonts.size 52
    , h2 = Fonts.size 45
    }

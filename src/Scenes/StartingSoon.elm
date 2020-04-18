module Scenes.StartingSoon exposing (view)

{-| A scene for before the stream starts.
-}

import Html exposing (Html)


view : Html msg
view =
    -- TODO: port scenes/1-starting.html.mustache
    Html.text "!! Starting Soon!"

module Partials exposing (charity)

{-| View snippets used in multiple scenes.
-}

import Charities
import Html exposing (..)
import Html.Attributes exposing (..)


charity : Charities.CharityInfo -> Html msg
charity info =
    div
        [ class "positioned"
        , style "bottom" "0"
        , style "height" "120px"
        , style "font-size" "20px"
        , style "padding" "20px"
        ]
        [ span
            [ class "dim" ]
            [ text "Today's charity: " ]
        , text info.name
        , br [] []
        , span
            [ class "dim" ]
            [ text "Donate at " ]
        , a [] [ text info.donateLink ]
        ]

module Scenes.StartingSoon exposing (view)

{-| A scene for before the stream starts.
-}

import Data exposing (Data)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Extra exposing (viewMaybe)


view : Data -> Html msg
view data =
    main_
        [ class "main-scene gradient"
        , attribute "role" "main"
        ]
        [ div
            [ class "positioned"
            , style "width" "320px"
            , style "height" "100%"
            ]
            [ div
                [ style "padding" "100px 40px 100px 20px"
                , style "font-size" "20px"
                ]
                [ text (Maybe.withDefault "" data.summary)
                , br [] []
                , br [] []
                , br [] []

                -- TODO: show data.links here instead?
                , text "Elm 0.19 upgrade guide: "
                , a [] [ text "https://is.gd/xakovu" ]
                ]
            , let
                viewCharity charity =
                    div
                        [ class "positioned"
                        , style "bottom" "0"
                        , style "height" "170px"
                        , style "font-size" "20px"
                        , style "padding" "10px"
                        ]
                        [ span [ class "dim" ] [ text "Today's charity: " ]
                        , text charity.name
                        , br [] []
                        , div
                            [ style "font-size" "80%"
                            , style "line-height" "1.1"
                            , style "padding" "5px"
                            ]
                            [ i [] [ text charity.description ]
                            ]
                        , span [ class "dim" ] [ text "Donate at " ]
                        , a [] [ text charity.donateLink ]
                        ]
              in
              viewMaybe viewCharity data.charity
            ]
        , div
            [ class "positioned"
            , style "left" "320px"
            ]
            [ h1
                [ class "project-name" ]
                [ text data.title ]
            , h3 [] [ text "Today's Schedule" ]
            , let
                viewItem item =
                    li []
                        [ b [ class "schedule" ]
                            [ text (Maybe.withDefault "❧" item.time) ]
                        , text item.description
                        ]
              in
              ul [ class "large-schedule" ] <|
                List.map viewItem data.schedule.upcoming
            ]
        ]

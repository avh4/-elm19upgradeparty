module Scenes.Coding exposing (view)

{-| A scene for solo livecoding.
-}

import Data exposing (Data)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Extra exposing (viewMaybe)
import Partials


view : Data -> Html msg
view data =
    main_
        [ class "main-scene"
        , attribute "role" "main"
        ]
        [ div
            [ class "placeholder positioned"
            , id "screen"
            , style "width" "900px"
            , style "height" "720px"
            ]
            []
        , div
            [ class "positioned gradient"
            , style "left" "900px"
            , style "height" "100%"
            , style "right" "0"
            ]
            [ div
                [ class "placeholder positioned"
                , id "cam"
                , style "width" "100%"
                , style "height" "240px"
                ]
                []
            , div
                [ class "positioned fade-bottom"
                , style "top" "240px"
                , style "width" "100%"
                , style "height" "380px"
                , style "padding" "10px 20px"
                ]
                [ div
                    [ style "font-size" "24px"
                    , style "text-align" "center"
                    ]
                    [ text data.title ]
                , viewMaybe
                    (\summary ->
                        p []
                            [ text summary ]
                    )
                    data.summary
                , viewSchedule data.schedule
                ]
            , viewMaybe Partials.charity data.charity
            ]
        ]


viewSchedule : Data.Schedule -> Html msg
viewSchedule schedule =
    let
        viewScheduleItem item =
            li []
                [ viewMaybe (\time -> text (time ++ ": ")) item.time
                , text item.description
                ]
    in
    div []
        [ h3 [] [ text "Schedule" ]
        , ul [ class "schedule highlight-first" ] <|
            List.map viewScheduleItem schedule.upcoming
        ]

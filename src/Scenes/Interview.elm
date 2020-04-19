module Scenes.Interview exposing (view)

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
            , attribute "style" "left: 60px; top: 10px"
            ]
            [ h1
                [ class "project-name"
                , attribute "style" "padding: 10px"
                ]
                [ text data.title ]
            ]
        , div
            [ class "area positioned"
            , id "guest"
            , attribute "style" "width: 760px; height: 480px; top:140px; left:70px"
            ]
            [ div
                [ attribute "style" "text-align: center; line-height: 480px; opacity: 0.8"
                ]
                [ text "Audio only" ]
            ]
        , div
            [ class "area positioned"
            , id "cam"
            , attribute "style" "bottom: 20px; right: 20px; width: 380px; height: 240px;"
            ]
            []
        , div
            [ class "positioned"
            , attribute "style" "left: 880px; height: 100%; right: 0"
            ]
            [ div
                [ class "positioned fade-bottom"
                , attribute "style" "top: 20px; width: 100%; height: 400px; padding: 10px 20px"
                ]
                [ viewMaybe
                    (\summary -> p [] [ text summary ])
                    data.summary
                , h3 [] [ text "Schedule" ]
                , let
                    viewScheduleItem item =
                        li []
                            [ viewMaybe (\time -> text (time ++ ": ")) item.time
                            , text item.description
                            ]
                  in
                  ul [ class "schedule highlight-first" ] <|
                    List.map viewScheduleItem data.schedule.upcoming
                ]
            ]
        , let
            viewCharity info =
                div
                    [ class "positioned"
                    , attribute "style" "bottom: 10px; right: 440px; font-size: 20px; padding: 20px"
                    ]
                    [ span [ class "dim" ]
                        [ text "Today's charity: " ]
                    , text info.name
                    , text " — "
                    , span [ class "dim" ] [ text "Donate at " ]
                    , a [] [ text info.donateLink ]
                    ]
          in
          viewMaybe viewCharity data.charity
        ]

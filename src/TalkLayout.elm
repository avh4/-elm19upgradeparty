module TalkLayout exposing (Config, view)

import Components.Timer as Timer
import Data exposing (Data)
import Element exposing (..)
import Html exposing (Html, a, div, h1, h3, li, main_, p, span, ul)
import Html.Attributes exposing (attribute, class, id)
import Html.Extra exposing (viewMaybe)
import Time


type alias Config =
    { isGuest : Bool
    }


view : Config -> Time.Posix -> Data -> Html msg
view config now data =
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
                [ Html.text data.title ]
            ]
        , div
            [ class "area positioned"
            , if config.isGuest then
                id "guest"

              else
                id "cam"
            , attribute "style" "width: 760px; height: 480px; top:140px; left:70px"
            ]
            [ div
                [ attribute "style" "text-align: center; line-height: 480px; opacity: 0.8"
                ]
                [ Html.text "Audio only" ]
            ]
        , if config.isGuest then
            div
                [ class "area positioned"
                , id "cam"
                , attribute "style" "bottom: 20px; right: 20px; width: 380px; height: 240px;"
                ]
                []

          else
            Html.text ""
        , div
            [ class "positioned"
            , attribute "style" "left: 880px; height: 100%; right: 0"
            ]
            [ div
                [ class "positioned fade-bottom"
                , if config.isGuest then
                    attribute "style" "top: 60px; width: 100%; height: 380px; padding: 10px 20px"

                  else
                    attribute "style" "top: 80px; width: 100%; height: 600px; padding: 10px 20px"
                ]
                [ viewMaybe
                    (\summary -> p [] [ Html.text summary ])
                    data.summary
                , h3 [] [ Html.text "Schedule" ]
                , -- TODO: use same schedule view as ScreenShareLayout
                  let
                    viewScheduleItem item =
                        li []
                            [ viewMaybe (\time -> Html.text (time ++ ": ")) item.time
                            , Html.text item.description
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
                    [ span [ class "dim" ] [ Html.text "Today's charity: " ]
                    , Html.text info.name
                    , Html.text " — "
                    , span [ class "dim" ] [ Html.text "Donate at " ]
                    , a [] [ Html.text info.donateLink ]
                    ]
          in
          viewMaybe viewCharity data.charity
        , layout []
            (row
                [ height fill
                , width fill
                ]
                [ column
                    [ height fill
                    , width (px 400)
                    , alignRight
                    ]
                  <|
                    List.filterMap identity
                        [ Maybe.map (el [ alignBottom, width fill ] << Timer.view now) data.timer
                        ]
                ]
            )
        ]

module ScheduleLayout exposing (Config, view)

import Data exposing (Data)
import Element exposing (..)
import Element.Font as Fonts
import Html exposing (Html, a, b, br, div, h1, h3, i, li, main_, span, ul)
import Html.Attributes exposing (attribute, class, style)
import Html.Extra exposing (viewMaybe)
import Palette


type alias Config =
    { fadeBottom : Bool
    , sceneTitle : Maybe String
    , scheduleTitle : String
    , highlightFirst : Bool
    }


view : Config -> Data -> Html msg
view config data =
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
                [ Html.text (Maybe.withDefault "" data.summary)
                , br [] []
                , br [] []
                , br [] []
                , if data.links /= [] then
                    Html.text "Today's links:"

                  else
                    Html.text ""
                , let
                    viewLink link =
                        div
                            [ style "line-height" "1"
                            , style "margin-top" "2px"
                            , style "margin-bottom" "8px"
                            ]
                            [ a [] [ Html.text <| String.replace "/" "\u{200B}/" link ] ]
                  in
                  div [] <|
                    List.map viewLink data.links
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
                        [ span [ class "dim" ] [ Html.text "Today's charity: " ]
                        , Html.text charity.name
                        , br [] []
                        , div
                            [ style "font-size" "80%"
                            , style "line-height" "1.1"
                            , style "padding" "5px"
                            ]
                            [ i [] [ Html.text charity.description ]
                            ]
                        , span [ class "dim" ] [ Html.text "Donate at " ]
                        , a [] [ Html.text charity.donateLink ]
                        ]
              in
              viewMaybe viewCharity data.charity
            ]
        , div
            [ class <|
                if config.fadeBottom then
                    "positioned fade-bottom"

                else
                    "positioned"
            , style "left" "320px"
            ]
            [ h1
                [ class "project-name" ]
                [ Html.text data.title ]
            , [ Maybe.map
                    (\title ->
                        el
                            [ Palette.fontSize.h2
                            , Fonts.bold
                            ]
                            (text title)
                    )
                    config.sceneTitle
              ]
                |> List.filterMap identity
                |> column
                    [ paddingEach { top = 45, bottom = 25, left = 0, right = 0 }
                    ]
                |> layout [ Fonts.color Palette.color.mainText ]
            , h3 [] [ Html.text config.scheduleTitle ]
            , let
                viewItem item =
                    li []
                        [ b [ class "schedule" ]
                            [ Html.text (Maybe.withDefault "❧" item.time) ]
                        , Html.text item.description
                        ]
              in
              ul
                [ class <|
                    if config.highlightFirst then
                        "large-schedule highlight-first"

                    else
                        "large-schedule"
                ]
              <|
                List.map viewItem data.schedule.upcoming
            , br [] []
            ]
        , let
            viewMusic info =
                div
                    [ class "positioned"
                    , style "right" "15px"
                    , style "bottom" "10px"
                    , style "font-size" "16px"
                    ]
                    [ span [ class "dim" ] [ Html.text "Music by " ]
                    , Html.text info.name
                    , Html.text " "
                    , a [] [ Html.text info.link ]
                    ]
          in
          viewMaybe viewMusic data.music
        ]

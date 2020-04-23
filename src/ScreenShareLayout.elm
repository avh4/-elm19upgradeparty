module ScreenShareLayout exposing (Config, view)

import Components.Timer as Timer
import Data exposing (Data)
import Element exposing (..)
import Html exposing (Html, a, br, div, h3, li, main_, p, span, ul)
import Html.Attributes exposing (attribute, class, id, style)
import Html.Extra exposing (viewMaybe)
import Time


type alias Config =
    { showTopCam : Bool
    , showBottomCam : Bool
    }


view : Config -> Time.Posix -> Data -> Html msg
view config now data =
    let
        totalHeight =
            720

        topCamHeight =
            if config.showTopCam then
                240

            else
                0

        bottomCamHeight =
            if config.showBottomCam then
                220

            else
                0

        charityHeight =
            if
                (totalHeight - (topCamHeight + bottomCamHeight) > 400)
                    && (data.charity /= Nothing)
            then
                120

            else
                0

        infoHeight =
            totalHeight
                - (topCamHeight + bottomCamHeight + charityHeight)

        tightLayout =
            infoHeight < 300
    in
    main_
        [ class "main-scene"
        , attribute "role" "main"
        ]
        [ div
            [ class "placeholder positioned"
            , id "screen"
            , style "width" "900px"
            , style "height" (String.fromInt totalHeight ++ "px")
            ]
            []
        , div
            [ class "positioned gradient"
            , style "left" "900px"
            , style "height" "100%"
            , style "right" "0"
            ]
            [ if topCamHeight > 0 then
                div
                    [ class "placeholder positioned"
                    , id "cam"
                    , style "width" "100%"
                    , style "height" (String.fromInt topCamHeight ++ "px")
                    ]
                    []

              else
                Html.text ""
            , div
                [ class "positioned fade-bottom"
                , style "top" (String.fromInt topCamHeight ++ "px")
                , style "width" "100%"
                , style "height" (String.fromInt infoHeight ++ "px")
                , style "padding" "10px 20px"
                ]
                [ div
                    [ style "font-size" "24px"
                    , style "text-align" "center"
                    ]
                    [ Html.text data.title ]
                , viewMaybe
                    (\summary ->
                        p
                            (if tightLayout then
                                [ style "font-size" "18px" ]

                             else
                                []
                            )
                            [ Html.text summary ]
                    )
                    data.summary
                , viewSchedule tightLayout data.schedule
                ]
            , let
                viewCharity info =
                    div
                        [ class "positioned"
                        , style "bottom" "0"
                        , style "height" (String.fromInt charityHeight ++ "px")
                        , style "font-size" "20px"
                        , style "padding" "20px"
                        ]
                        [ span
                            [ class "dim" ]
                            [ Html.text "Today's charity: " ]
                        , Html.text info.name
                        , br [] []
                        , span
                            [ class "dim" ]
                            [ Html.text "Donate at " ]
                        , a [] [ Html.text info.donateLink ]
                        ]
              in
              if charityHeight > 0 then
                viewMaybe viewCharity data.charity

              else
                Html.text ""
            , layout [] <|
                column
                    [ height fill
                    , width fill
                    ]
                <|
                    List.filterMap identity
                        [ Maybe.map (el [ alignBottom, width fill ] << Timer.view now) data.timer
                        ]
            ]
        ]


viewSchedule : Bool -> Data.Schedule -> Html msg
viewSchedule tightLayout schedule =
    let
        viewScheduleItem i item =
            li
                (if i == 0 then
                    [ style "border-left" "4px solid #fdbcff"
                    , style "margin-left" "-13px"
                    , style "padding-left" "9px"
                    ]

                 else
                    []
                )
                [ viewMaybe (\time -> Html.text (time ++ ": ")) item.time
                , Html.text item.description
                ]
    in
    div []
        [ h3
            (if tightLayout then
                [ style "margin-top" "10px" ]

             else
                []
            )
            [ Html.text "Schedule" ]
        , ul [ class "schedule highlight-first" ] <|
            List.indexedMap viewScheduleItem schedule.upcoming
        ]

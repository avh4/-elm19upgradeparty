module ScreenShareLayout exposing (Config, view)

import Charities
import Data exposing (Data)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Extra exposing (viewMaybe)


type alias Config =
    { showTopCam : Bool
    , showBottomCam : Bool
    }


view : Config -> Data -> Html msg
view config data =
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
                text ""
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
                    [ text data.title ]
                , viewMaybe
                    (\summary ->
                        p
                            (if tightLayout then
                                [ style "font-size" "18px" ]

                             else
                                []
                            )
                            [ text summary ]
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
                            [ text "Today's charity: " ]
                        , text info.name
                        , br [] []
                        , span
                            [ class "dim" ]
                            [ text "Donate at " ]
                        , a [] [ text info.donateLink ]
                        ]
              in
              if charityHeight > 0 then
                viewMaybe viewCharity data.charity

              else
                text ""
            ]
        ]


viewSchedule : Bool -> Data.Schedule -> Html msg
viewSchedule tightLayout schedule =
    let
        viewScheduleItem item =
            li []
                [ viewMaybe (\time -> text (time ++ ": ")) item.time
                , text item.description
                ]
    in
    div []
        [ h3
            (if tightLayout then
                [ style "margin-top" "10px" ]

             else
                []
            )
            [ text "Schedule" ]
        , ul [ class "schedule highlight-first" ] <|
            List.map viewScheduleItem schedule.upcoming
        ]

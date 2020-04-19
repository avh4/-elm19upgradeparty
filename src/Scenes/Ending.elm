module Scenes.Ending exposing (view)

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
            , style "left" "200px"
            , style "right" "200px"
            , style "text-align" "center"
            ]
            [ h1 [ class "project-name" ] [ text "Thanks for watching!" ]
            , h2 [] [ text data.title ]
            , div []
                [ text "Learn more about Elm: "
                , a [ href "https://guide.elm-lang.org" ]
                    [ text "https://guide.elm-lang.org" ]
                ]
            , br [] []
            , br [] []

            -- TODO: add Twitter logo
            , text "@avh4"
            ]
        , let
            viewCharity charity =
                div
                    [ class "positioned"
                    , style "bottom" "20px"
                    , style "left" "0"
                    , style "right" "0"
                    , style "font-size" "20px"
                    , style "padding" "10px"
                    , style "text-align" "center"
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

module Main exposing (..)

import Browser
import Browser.Navigation
import Data exposing (Data)
import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes exposing (href, style)
import Scenes.Break as Break
import Scenes.Calendar as Calendar
import Scenes.Coding as Coding
import Scenes.Ending as Ending
import Scenes.Interview as Interview
import Scenes.Pairing as Pairing
import Scenes.StartingSoon as StartingSoon
import Scenes.Talk as Talk
import Task
import Time
import Url exposing (Url)
import Url.Parser as Url


main =
    Browser.application
        { init =
            \() url key ->
                ( init key url
                , Task.perform OnTimeZoneChange Time.here
                )
        , view =
            \model ->
                { title =
                    model.scene
                        |> Maybe.map Debug.toString
                        |> Maybe.withDefault "ERROR"
                , body =
                    case model.now of
                        Nothing ->
                            []

                        Just now ->
                            [ view now model ]
                }
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


subscriptions _ =
    Time.every 1000 Tick


type Msg
    = OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url
    | OnTimeZoneChange Time.Zone
    | Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlRequest (Browser.Internal url) ->
            ( model
            , Browser.Navigation.pushUrl model.key (Url.toString url)
            )

        OnUrlRequest (Browser.External url) ->
            ( model
            , Browser.Navigation.load url
            )

        OnUrlChange url ->
            ( init model.key url
            , Cmd.none
            )

        OnTimeZoneChange timezone ->
            ( { model | timezone = Just timezone }
            , Cmd.none
            )

        Tick now ->
            ( { model | now = Just now }
            , Cmd.none
            )


type Scene
    = StartingSoon
    | Coding
    | Break
    | Ending
    | Pairing
    | Interview
    | Talk
    | Calendar


allScenes : List ( Scene, String )
allScenes =
    [ ( StartingSoon, "start" )
    , ( Coding, "code" )
    , ( Break, "break" )
    , ( Ending, "end" )
    , ( Pairing, "pairing" )
    , ( Interview, "interview" )
    , ( Talk, "talk" )
    , ( Calendar, "calendar" )
    ]


type alias Model =
    { key : Browser.Navigation.Key
    , scene : Maybe Scene
    , data : Data
    , timezone : Maybe Time.Zone
    , now : Maybe Time.Posix
    }


init : Browser.Navigation.Key -> Url -> Model
init key url =
    let
        parser =
            Url.oneOf <|
                List.map
                    (\( scene, path ) -> Url.map scene (Url.s path))
                    allScenes
    in
    { key = key
    , scene = Url.parse parser url
    , data = Data.data
    , timezone = Nothing
    , now = Nothing
    }


view : Time.Posix -> Model -> Html msg
view now model =
    case model.scene of
        Just StartingSoon ->
            StartingSoon.view now model.data

        Just Coding ->
            Coding.view now model.data

        Just Break ->
            Break.view now model.data

        Just Ending ->
            Ending.view model.data

        Just Pairing ->
            Pairing.view now model.data

        Just Interview ->
            Interview.view now model.data

        Just Talk ->
            Talk.view now model.data

        Just Calendar ->
            Calendar.view
                |> Element.layout [ Background.color (rgb 0.2 0.2 0.2) ]

        Nothing ->
            Html.ul
                [ style "font-size" "30px"
                , style "background-color" "#333"
                , style "min-height" "100vh"
                ]
            <|
                List.map
                    (\( _, path ) -> Html.li [] [ Html.a [ href ("/" ++ path) ] [ Html.text path ] ])
                    allScenes

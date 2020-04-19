module Main exposing (..)

import Browser
import Data exposing (Data)
import Html exposing (Html)
import Html.Attributes exposing (..)
import Scenes.Coding as Coding
import Scenes.StartingSoon as StartingSoon
import Url exposing (Url)
import Url.Parser as Url


main =
    Browser.application
        { init =
            \() url _ ->
                ( init url, Cmd.none )
        , view =
            \model ->
                { title =
                    model.scene
                        |> Maybe.map Debug.toString
                        |> Maybe.withDefault "ERROR"
                , body =
                    let
                        stylesheet cssFile =
                            Html.node "link"
                                [ rel "stylesheet"
                                , type_ "text/css"
                                , href cssFile
                                ]
                                []
                    in
                    [ stylesheet "normalize.css"
                    , stylesheet "scenes/scenes.css"
                    , view model
                    ]
                }
        , update = update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = OnUrlRequest
        , onUrlChange = OnUrlChange
        }


type Msg
    = OnUrlRequest Browser.UrlRequest
    | OnUrlChange Url


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


type Scene
    = StartingSoon
    | Coding


type alias Model =
    { scene : Maybe Scene
    , data : Data
    }


init : Url -> Model
init url =
    let
        parser =
            Url.oneOf
                [ Url.map StartingSoon (Url.s "start")
                , Url.map Coding (Url.s "code")
                ]
    in
    { scene = Url.parse parser url
    , data = Data.data
    }


view : Model -> Html msg
view model =
    case model.scene of
        Just StartingSoon ->
            StartingSoon.view model.data

        Just Coding ->
            Coding.view model.data

        Nothing ->
            Html.text "Bad URL"

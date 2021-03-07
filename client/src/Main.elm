module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D exposing (Decoder)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



--MODEL


type alias Model =
    { state : State,
      currentId : Int
    }


type State
    = Init
    | Waiting
    | Loaded Test


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Init 0
    , Cmd.none
    )



--UPDATE


type Msg
    = ChangeId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeId ->
            ( model, Cmd.none )



--VIEW


view : Model -> Html Msg
view model =
    div []
        [text "Hello world!"]



--Data


type alias Test =
    { str : String
    }



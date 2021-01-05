import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as D exposing (Decoder)

--先にhaskellを書いて、取得するものを決める

main : Program () Model Msg
main =
    Browser.element
        {
            init = init
            , view = view
            , update = update
            , subscriptions = \_ -> Sub.none
        }

--MODEL

type alias Model =
    {
        input : String
    }

--UPDATE


--VIEW
view : Model -> Html Msg
view model =
  div []
    [

    ]

--Data
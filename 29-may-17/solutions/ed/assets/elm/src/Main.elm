module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main =
  Html.program
   { init = init
   , view = view
   , update = update
   , subscriptions = subscriptions
   }


-- MODEL


type alias Model =
  { query : String
  }

init : (Model, Cmd Msg)
init =
  (Model "", Cmd.none)

-- UPDATE


type Msg = Search String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Search query ->
      (Model query, Cmd.none)


-- VIEW


view : Model -> Html Msg
view model =
  div []
  [ input [type_ "text", placeholder "user", onInput Search ] []
  , p [] [ text model.query ]
  ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

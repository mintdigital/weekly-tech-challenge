module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import WebSocket

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
  , results : String
  }

init : (Model, Cmd Msg)
init =
  (Model "" "", Cmd.none)

-- UPDATE


type Msg
  = Search String
  | Results String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Search query ->
      ({ model | query = query }, WebSocket.send "ws://todo" query)

    Results string ->
      ({ model | results = string }, Cmd.none)


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
  WebSocket.listen "ws://todo" Results

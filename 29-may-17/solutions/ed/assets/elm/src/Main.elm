module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import WebSocket
import Json.Encode exposing (..)

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
  let model =
    Model "" ""
  in update Join model

-- UPDATE


type Msg
  = Search String
  | Results String
  | Join

type alias Send =
  { topic : String
  , event : String
  , payload : String
  , ref : String
  }

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Join ->
      let body = Send "typeahead:public" "phx_join" "typeahead:join" "1"

      in
        ( model
        , WebSocket.send "ws://localhost:4000/socket/websocket" (encode body)
        )

    Search query ->
      let body = Send "typeahead:public" "search" query "1"

      in
        ( { model | query = query }
        , WebSocket.send "ws://localhost:4000/socket/websocket" (encode body)
        )

    Results string ->
      let results =
        decode string

      in
        ({ model | results = results }, Cmd.none)


encode : Send -> String
encode search =
  Json.Encode.object
    [ ("topic", string search.topic )
    , ("event", string search.event )
    , ("payload", encodePayload search.payload )
    , ("ref", string search.ref )
    ]
  |> Json.Encode.encode 0


decode : String -> String
decode string =
  string


encodePayload : String -> Json.Encode.Value
encodePayload payload =
  Json.Encode.object
    [ ("query", string payload ) ]


-- VIEW


view : Model -> Html Msg
view model =
  div []
  [ input [type_ "text", placeholder "user", onInput Search ] []
  , p [] [ text model.results ]
  ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://localhost:4000/socket/websocket" Results

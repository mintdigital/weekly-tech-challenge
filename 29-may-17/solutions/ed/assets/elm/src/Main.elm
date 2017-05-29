module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import WebSocket
import Json.Encode exposing (..)
import Json.Decode exposing (..)

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
  , results : List User
  }

init : (Model, Cmd Msg)
init =
  let model =
    Model "" []
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

type alias User =
  { name : String
  , login : String
  , avatarUrl : String
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
      case decodeString (responseDecoder) string of
        Ok results ->
          Debug.log "ok"
          ({ model | results = results }, Cmd.none)

        Err err ->
          Debug.log err
          Debug.log "not ok"
          (model, Cmd.none)


encode : Send -> String
encode search =
  Json.Encode.object
    [ ("topic", Json.Encode.string search.topic )
    , ("event", Json.Encode.string search.event )
    , ("payload", encodePayload search.payload )
    , ("ref", Json.Encode.string search.ref )
    ]
  |> Json.Encode.encode 0

responseDecoder : Decoder (List User)
responseDecoder =
  at ["payload", "results"] (Json.Decode.list userDecoder)

userDecoder : Decoder User
userDecoder =
  map3
    User
    (at ["node", "name"] Json.Decode.string)
    (at ["node", "login"] Json.Decode.string)
    (at ["node", "avatarUrl"] Json.Decode.string)

encodePayload : String -> Json.Encode.Value
encodePayload payload =
  Json.Encode.object
    [ ("query", Json.Encode.string payload ) ]


-- VIEW


view : Model -> Html Msg
view model =
  div []
  [ input [type_ "text", placeholder "user", onInput Search ] []
  , viewResults model.results
  ]


viewResults : List User -> Html Msg
viewResults users =
  ul []
  (List.map (\l -> li [] [ h1 [] [text l.name]
                         , text l.login
                         , img [src l.avatarUrl] []
                         ]) users)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "ws://localhost:4000/socket/websocket" Results

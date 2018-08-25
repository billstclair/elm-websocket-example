module Main exposing (main)

{-| WebSocket example
-}

import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (size, value)
import Html.Events exposing (onClick, onInput)
import WebSocket


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    --Sub.none
    WebSocket.listen url Receive



-- MODEL


url : String
url =
    "ws://echo.websocket.org"


type alias Model =
    { send : String
    , receive : String
    }


init : ( Model, Cmd Msg )
init =
    ( { send = "Hello World!"
      , receive = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = UpdateSend String
    | Send
    | Receive String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSend send ->
            ( { model | send = send }, Cmd.none )

        Send ->
            ( model
            , --Cmd.none
              WebSocket.send url model.send
            )

        Receive receive ->
            ( { model | receive = receive }
            , Cmd.none
            )



-- VIEW


b : String -> Html Msg
b string =
    Html.b [] [ text string ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input
                [ value model.send
                , onInput UpdateSend
                , size 50
                ]
                []
            , text " "
            , button [ onClick Send ] [ text "Send" ]
            ]
        , div []
            [ b "Received: "
            , text model.receive
            ]
        ]

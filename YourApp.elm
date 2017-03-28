port module YourApp exposing (..)

import Process
import Task
import Time exposing (Time)


{- REMOVE WHEN COMPILER BUG IS FIXED -}

import Json.Decode


port exitApp : Float -> Cmd msg


port externalStop : (() -> msg) -> Sub msg


main : Program Never Model Msg
main =
    Platform.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    {}


type Msg
    = Stop
    | Abort


init : ( Model, Cmd Msg )
init =
    {}
        ! [ delayMsg 3000 <| Stop
          ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Stop ->
            model ! [ exitApp 0 ]

        Abort ->
            model ! [ exitApp -1 ]


subscriptions : Model -> Sub Msg
subscriptions model =
    externalStop <| always Abort



-- UTILITIES


delayMsg : Time -> Msg -> Cmd Msg
delayMsg time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)

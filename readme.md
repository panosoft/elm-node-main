# Node main for Server-side Elm

> Node main for Server-side Elm programs

## Install

There's no installation necessary, this is a boilerplate file that can be used as the entry point for all Server-side or command line based Elm programs.

## Usage

Your final output of your Elm build must be called `elm.js`. This will be loaded via `require` in `main.js`:

```
elm make YourApp.elm --output elm.js
```

Then your main Elm App should be a port module:

```elm
port module YourApp exposing (..)

```

Then your Elm code can initiate a controlled shutdown by writing the exit code to a port called `node`:

```elm
port exitApp : Float -> Cmd msg
```

When it's time to exit, your `update` function can do the following:

```elm

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
		SomeEvent ->
			(model, exitApp 1)
```
See `YourApp.elm` code for more usage details.

## SIGINT and SIGTERM

These OS signals will send a message to your program. In the case of the test app, `YourApp.elm`, an `Abort` message is sent. Then the `exitApp` Cmd is returned from `update` with a parameter of -1 which will be returned to the OS.

This approach allows your Elm code to shutdown cleanly and allows you Elm code to always be in control.

## Exit Handlers

Besides the Elm exit handler, it also has a handler for Unhandled Exceptions which returns 1 to the OS. This is useful if you've written or used any badly behaved Javascript code.

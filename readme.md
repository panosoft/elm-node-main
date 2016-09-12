# Node main for Server-side Elm

> Node main for Server-side Elm programs

## Install

There's no installation necessary, this is a boilerplate file that can be used as the entry point for all Server-side Elm programs.

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
port node : Float -> Cmd msg
```

When it's time to exit, your `update` function can do the following:

```elm

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
		SomeEvent ->
			(model, node 1)
```

## Exit Handlers

Besides the Elm exit handler, it also has a handler for:

* Unhandled Exceptions
* SIGINT
* SIGTERM

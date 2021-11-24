# HTTP Authentication


The app has two toggleable interfaces, a `SignIn` and a `Register` interface with:

- A `UserProvider` that exposes a stream.
- A root `StreamProvider` to check for the provided stream changes.
- A `Wrapper` that listen to the stream changes & displays the appropriate page appropriately (Either `Authenticate` or `Home`)

<div align="center">

![](/media/stream_auth.gif)
</div>


**Note:** This application is just a way to experiment with a Stream in a custom provider; sort of like Angular's Behavior Subject. Simply using a simple provider value (instead of a stream) is more than enough in this case.

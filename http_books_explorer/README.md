# HTTP Books Explorer

The app mainly includes:
- A `GridView` that displays the books & changes based on the screen width.
- An `HttpHelper` class that takes care of fetching & parsing the data.
- A `MediaQuery` that detects the screen width changes.


**Note:** To start in chrome, start with `flutter run -d chrome --web-renderer html`,

<div align="center">

![](/media/http-books-explorer-portrait.png)
![](/media/http-books-explorer-landscape.png)
</div>

Application data is fetched from googleapis.com. Also note that this app does not use a `Future.builder`
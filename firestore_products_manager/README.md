# Firestore Producst Manager

The app mainly includes:
- A `FireStoreDbService` service that exposes the firestore CRUD operations.
- An `AuthService` to keep the application secure by design.
- A `Stream.builder` to reflect the changes to the list of products in **real-time.**

<div align="center">

![](/media/firestore-products-manager.gif)
</div>

**Note:** The `AuthService` is used by default for security reasons by signing in the user anonymously.

# SQLite database manager
A local relational database manager manager.

The database has two tables `Classrooms` & `Students` with a one classroom to many students relation. The main features of the app are:
- A `DbService` to handle all requests to the local database.
- A `FutureBuilder` to demonstrate how to get data asynchronously, along with a `ProgressIndicator`.
- A `Dismissible` list tile in a `ListView`.
- Emitting data changes from child to parent using custom notifiers to keep a single source of truth.
- `AlertDialog`s and how to catch data in the parent calling the dialog.


<div align="center">

![](/media/sqflite_classrooms.png)
</div>

<div align="center">

![](/media/sqflite_students.png)
</div>

<div align="center">

![](/media/sqflite_students_form.png)
</div>

One might notice the not so direct method of updating the `classrooms` & `students` using custom notifiers and data catchers. 

This emphasizes the need for a better state management system, such as the context `Provider`, which is coming up in future projects...
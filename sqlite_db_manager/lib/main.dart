import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/services/db_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbService _dbService = DbService();
    _dbService.testDB();

    return MaterialApp(
      title: "SQLite Database Manager",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const Text("Main App"),
    );
  }
}

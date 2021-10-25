import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';

class StudentsScreen extends StatelessWidget {
  final Classroom classroom;
  const StudentsScreen({Key? key, required this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classroom.name),
      ),
      body: const Text('Show students here!'),
    );
  }
}

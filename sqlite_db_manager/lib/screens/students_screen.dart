import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/models/student.dart';
import 'package:sqlite_db_manager/services/db_service.dart';

class StudentsScreen extends StatelessWidget {
  final Classroom classroom;
  const StudentsScreen({Key? key, required this.classroom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbService _dbService = DbService();

    return Scaffold(
      appBar: AppBar(
        title: Text(classroom.name),
      ),
      body: FutureBuilder(
        future: _dbService.getStudents(classroom.id),
        builder: (context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.hasData) {
            return const Text("data");
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

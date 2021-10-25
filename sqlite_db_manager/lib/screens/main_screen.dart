import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/services/db_service.dart';
import 'package:sqlite_db_manager/widgets/classrooms_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbService _dbService = DbService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Manager"),
      ),
      body: FutureBuilder(
        future: _dbService.getClassrooms(),
        builder: (context, AsyncSnapshot<List<Classroom>> snapshot) {
          if (snapshot.hasData) {
            return ClassroomsList(classrooms: snapshot.data!);
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

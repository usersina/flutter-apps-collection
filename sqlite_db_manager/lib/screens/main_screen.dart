import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/services/db_service.dart';
import 'package:sqlite_db_manager/widgets/classroom_dialog.dart';
import 'package:sqlite_db_manager/widgets/classrooms_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DbService _dbService = DbService();

  // The unique list that should be updated on CRUD operations
  // a.k.a The single source of truth
  List<Classroom>? classrooms;

  onClassroomsChange(List<Classroom> newList) {
    setState(() {
      classrooms = newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    logDBPpath();

    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Manager"),
      ),
      body: FutureBuilder(
        future: _dbService.getClassrooms(),
        builder: (context, AsyncSnapshot<List<Classroom>> snapshot) {
          if (snapshot.hasData) {
            // On first load, classrooms is null load from snapshot
            // On subsequent state changes, use updated classrooms
            classrooms = classrooms ?? snapshot.data!;
            return ClassroomsList(
              classrooms: classrooms!,
              notifyParentToChanges: onClassroomsChange,
            );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ClassroomDialog(
              onChanged: (e) {
                //
                // A cleaner way of updating would be using a StreamBuilder
                // instead of a FutureBuilder & adding 'e' to the stream.
                //
                // An even cleaner way is to use a global provider,
                // but that's better left for larger projects
                //
                setState(() {
                  classrooms!.add(e);
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future logDBPpath() async {
    String dbpath = await _dbService.getDBPath("classrooms.db");
    log(dbpath);
  }
}

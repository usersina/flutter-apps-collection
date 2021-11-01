import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/models/student.dart';
import 'package:sqlite_db_manager/services/db_service.dart';
import 'package:sqlite_db_manager/widgets/student_dialog.dart';
import 'package:sqlite_db_manager/widgets/students_list.dart';

class StudentsScreen extends StatefulWidget {
  final Classroom classroom;
  const StudentsScreen({Key? key, required this.classroom}) : super(key: key);

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final DbService _dbService = DbService();
  List<Student>? students;

  onStudentsChange(List<Student> newStudents) {
    setState(() {
      students = newStudents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.classroom.name),
      ),
      body: FutureBuilder(
        future: _dbService.getStudents(widget.classroom.id),
        builder: (context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.hasData) {
            students = students ?? snapshot.data!;
            // notifyParentToChanges: onStudentsChange,
            return StudentsList(students: students!);
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
            builder: (context) => StudentDialog(
              onChanged: (e) {
                setState(() {
                  students!.add(e);
                });
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

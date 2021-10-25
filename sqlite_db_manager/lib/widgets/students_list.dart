import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/student.dart';

class StudentsList extends StatefulWidget {
  final List<Student> students;
  const StudentsList({Key? key, required this.students}) : super(key: key);

  @override
  StudentsListState createState() => StudentsListState();
}

class StudentsListState extends State<StudentsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students.length,
      itemBuilder: (BuildContext context, int index) {
        Student student = widget.students[index];
        return ListTile(
          title: Text(
            '${student.firstname} ${student.lastname}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Birthday:  ${student.birthDate}'),
          onTap: () {},
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
    );
  }
}

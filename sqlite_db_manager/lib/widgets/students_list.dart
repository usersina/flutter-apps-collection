import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/student.dart';
import 'package:sqlite_db_manager/widgets/student_dialog.dart';

class StudentsList extends StatefulWidget {
  final List<Student> students;
  final Function notifyParentToChanges;
  const StudentsList({
    Key? key,
    required this.students,
    required this.notifyParentToChanges,
  }) : super(key: key);

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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => StudentDialog(
                  student: student,
                  classroomId: student.classroomId,
                  onChanged: (respStudent) {
                    List<Student> students = widget.students.map(
                      (stud) {
                        if (stud.id == respStudent.id) {
                          stud = respStudent;
                        }
                        return stud;
                      },
                    ).toList();
                    widget.notifyParentToChanges(students);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

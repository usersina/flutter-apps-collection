import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_db_manager/models/student.dart';
import 'package:sqlite_db_manager/services/db_service.dart';

class StudentDialog extends StatelessWidget {
  final Student? student;
  final int classroomId;
  final ValueChanged<Student> onChanged;
  const StudentDialog({
    Key? key,
    this.student,
    required this.classroomId,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool isNew = student == null ? true : false;
    final firstNameController = TextEditingController(
      text: student == null ? '' : student!.firstname,
    );
    final lastNameController = TextEditingController(
      text: student == null ? '' : student!.lastname,
    );
    final dateTextController = TextEditingController(
      text: student == null ? '' : student!.birthDate,
    );

    final df = DateFormat('dd-MM-yyyy');
    final DbService _dbService = DbService();
    DateTime selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995),
        lastDate: DateTime(2050),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        dateTextController.text = df.format(pickedDate);
      }
    }

    log("Building view!");
    return AlertDialog(
      title: Text(isNew ? 'Add a new student' : 'Edit student'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: "First name",
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: "Last name",
              ),
            ),
            TextField(
              controller: dateTextController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Birthdate",
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            ElevatedButton(
              onPressed: () async {
                late Student myStudent;
                switch (isNew) {
                  case true: // -- Create a new student
                    if (firstNameController.text.isEmpty ||
                        lastNameController.text.isEmpty ||
                        dateTextController.text.isEmpty) {
                      // Maybe show a toast or sth
                      // Close the dialog without proceeding
                      return Navigator.pop(context);
                    }
                    myStudent = await _dbService.createStudent(
                      lastNameController.text,
                      firstNameController.text,
                      dateTextController.text,
                      classroomId,
                    );
                    break;
                  case false: // -- Update an existing student
                    myStudent = await _dbService.updateStudent(
                      student!.id,
                      lastNameController.text,
                      firstNameController.text,
                      dateTextController.text,
                      classroomId,
                    );
                    break;
                }
                // -- Forward change to parent
                onChanged(myStudent);
                // -- Close the dialog
                Navigator.pop(context);
              },
              child: Text(isNew ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}

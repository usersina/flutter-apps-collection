import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_db_manager/models/student.dart';

class StudentDialog extends StatefulWidget {
  final Student? student;
  final ValueChanged<Student> onChanged;
  const StudentDialog({Key? key, this.student, required this.onChanged})
      : super(key: key);

  @override
  State<StudentDialog> createState() => _StudentDialogState();
}

class _StudentDialogState extends State<StudentDialog> {
  late bool isNew = widget.student == null ? true : false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateTextController = TextEditingController();

  final df = DateFormat('dd-MM-yyyy');
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
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                // late Student myStudent;
                // switch (isNew) {
                //   case true: // -- Create a new classroom
                //     if (nameController.text.isEmpty) {
                //       // Maybe show a toast or sth
                //       // Close the dialog without proceeding
                //       return Navigator.pop(context);
                //     }
                //     myStudent =
                //         await _dbService.createClassroom(nameController.text);
                //     break;
                //   case false: // -- Update an existing classroom
                //     myStudent = await _dbService.updateClassroom(
                //       myStudent!.id,
                //       nameController.text,
                //     );
                //     break;
                // }
                // // -- Forward change to parent
                // onChanged(myClassroom);
                // // -- Close the dialog
                // Navigator.pop(context);
              },
              child: Text(isNew ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}

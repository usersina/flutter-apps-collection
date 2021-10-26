import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/services/db_service.dart';

class ClassroomDialog extends StatelessWidget {
  final Classroom? classroom;
  final ValueChanged<Classroom> onChanged;
  const ClassroomDialog({
    Key? key,
    this.classroom,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isNew = classroom == null ? true : false;
    final nameController = TextEditingController();

    nameController.text = classroom == null ? '' : classroom!.name;
    DbService _dbService = DbService();
    return AlertDialog(
      title: Text(isNew ? 'Add new classroom' : 'Edit classroom'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: nameController),
            ElevatedButton(
              onPressed: () async {
                late Classroom myClassroom;
                switch (isNew) {
                  case true: // -- Create a new classroom
                    if (nameController.text.isEmpty) {
                      // Maybe show a toast or sth
                      // Close the dialog without proceeding
                      return Navigator.pop(context);
                    }
                    myClassroom =
                        await _dbService.createClassroom(nameController.text);
                    break;
                  case false: // -- Update an existing classroom
                    myClassroom = await _dbService.updateClassroom(
                      classroom!.id,
                      nameController.text,
                    );
                    break;
                }
                // -- Forward change to parent
                onChanged(myClassroom);
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

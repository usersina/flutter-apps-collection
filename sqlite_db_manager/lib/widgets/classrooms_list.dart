import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/screens/students_screen.dart';
import 'package:sqlite_db_manager/services/db_service.dart';
import 'package:sqlite_db_manager/widgets/classroom_dialog.dart';

class ClassroomsList extends StatefulWidget {
  final List<Classroom> classrooms;
  final Function notifyParentToChanges;
  const ClassroomsList({
    Key? key,
    required this.classrooms,
    required this.notifyParentToChanges,
  }) : super(key: key);

  @override
  _ClassroomsListState createState() => _ClassroomsListState();
}

class _ClassroomsListState extends State<ClassroomsList> {
  @override
  Widget build(BuildContext context) {
    DbService _dbService = DbService();

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: widget.classrooms.length,
        itemBuilder: (BuildContext context, int index) {
          Classroom classroom = widget.classrooms[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentsScreen(
                          classroom: classroom,
                        ),
                      ),
                    );
                  },
                  title: Text(classroom.name),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(classroom.name),
                  //     Text(classroom.id.toString()),
                  //   ],
                  // ),
                  leading: CircleAvatar(
                    child: Text(classroom.id.toString()),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ClassroomDialog(
                              classroom: classroom,
                              onChanged: (respClass) {
                                List<Classroom> classrooms =
                                    widget.classrooms.map(
                                  (classr) {
                                    if (classr.id == respClass.id) {
                                      classr.name = respClass.name;
                                    }
                                    return classr;
                                  },
                                ).toList();
                                widget.notifyParentToChanges(classrooms);
                              },
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _dbService.deleteClassroom(classroom.id);
                          List<Classroom> classrooms = widget.classrooms
                              .where(
                                (classr) => classr.id != classroom.id,
                              )
                              .toList();
                          widget.notifyParentToChanges(classrooms);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

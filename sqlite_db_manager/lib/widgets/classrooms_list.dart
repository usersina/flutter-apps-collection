import 'package:flutter/material.dart';
import 'package:sqlite_db_manager/models/classroom.dart';
import 'package:sqlite_db_manager/screens/students_screen.dart';

class ClassroomsList extends StatefulWidget {
  final List<Classroom> classrooms;
  const ClassroomsList({Key? key, required this.classrooms}) : super(key: key);

  @override
  _ClassroomsListState createState() => _ClassroomsListState();
}

class _ClassroomsListState extends State<ClassroomsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        itemCount: widget.classrooms.length,
        itemBuilder: (BuildContext context, int index) {
          Classroom classroom = widget.classrooms[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
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
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(classroom.name),
                    Text(classroom.id.toString()),
                  ],
                ),
                // leading: CircleAvatar(
                //   child: Text(classroom.id.toString()),
                // ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

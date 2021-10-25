class Student {
  int id;
  String lastname;
  String firstname;
  String birthDate;
  int classroomId;

  Student(
      this.id, this.lastname, this.firstname, this.birthDate, this.classroomId);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'birth_date': birthDate,
      'classroom_id': classroomId,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) => Student(
        map['id'],
        map['lastname'],
        map['firstname'],
        map['birth_date'],
        map['classroom_id'],
      );
}

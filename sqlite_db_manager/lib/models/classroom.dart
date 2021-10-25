class Classroom {
  int id;
  String name;

  Classroom(this.id, this.name);

  Map<String, dynamic> toMap() => {'id': id, 'name': name};

  factory Classroom.fromMap(Map<String, dynamic> map) =>
      Classroom(map['id'], map['name']);
}

class User {
  int id;
  String email;

  User(this.id, this.email);

  factory User.fromMap(
    Map<String, dynamic> map,
  ) =>
      User(
        map["id"],
        map["email"],
      );
}

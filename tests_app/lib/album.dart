class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> obj) {
    return Album(
      userId: obj['userId'],
      id: obj['id'],
      title: obj['title'],
    );
  }
}

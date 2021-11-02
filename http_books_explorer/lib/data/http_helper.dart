import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_books_explorer/models/book.dart';

class HttpHelper {
  final String authority = 'www.googleapis.com';
  final String path = '/books/v1/volumes';

  Map<String, dynamic> params = {
    'q': 'query',
    'maxResults': '40',
  };

  Future<List<Book>> getBooks(String query) async {
    Uri uri = Uri.https(authority, path, params);
    Response result = await get(uri);

    if (result.statusCode != 200) return [];

    final jsonResponse = json.decode(result.body);
    final booksMap = jsonResponse['items'];
    List<Book> books = booksMap
        .map<Book>(
          (i) => Book.fromJson(i),
        )
        .toList();
    return books;
  }
}

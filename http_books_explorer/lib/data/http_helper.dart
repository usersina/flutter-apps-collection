import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_books_explorer/models/book.dart';

class HttpHelper {
  // -- Equivalent to calling (with query = "flutter")
  // -- https://www.googleapis.com/books/v1/volumes?q=flutter&maxResults=40
  //
  final String authority = 'www.googleapis.com';
  final String path = '/books/v1/volumes';

  Future<List<Book>> getBooks(String query) async {
    Map<String, dynamic> params = {
      'q': query,
      'maxResults': '40',
    };

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

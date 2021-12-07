import 'dart:convert';

import 'package:tests_app/album.dart';
import 'package:http/http.dart';

class HttpService {
  final String baseUrl = "https://jsonplaceholder.typicode.com/albums/1";

  Future<Album> fetchAlbum(Client httpClient) async {
    final response = await httpClient.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Could not load album!");
    }
  }
}

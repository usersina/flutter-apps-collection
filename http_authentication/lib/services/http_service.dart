import 'dart:convert';

import 'package:http/http.dart';

class HttpService {
  final String baseUrl = "http://10.0.2.2:8080/";

  // -- TESTME:
  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    dynamic res = await post(
      Uri.parse(baseUrl + "register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );
    return res.body;
  }

  // -- TESTME:
  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    dynamic res = await post(
      Uri.parse(baseUrl + "login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );
    return res.body;
  }
}

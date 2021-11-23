import 'package:flutter/material.dart';
import 'package:http_authentication/screens/authenticate/authenticate.dart';
// import 'package:http_authentication/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // -- TODO:
    // 1. Create a custom auth stream
    // 2. Listen for auth stream changes
    // 3. Display either Home() or Authenticate()
    //    depending on whether stream value is null or not
    return const Authenticate();
  }
}

import 'package:flutter/material.dart';
import 'package:http_authentication/screens/authenticate/authenticate.dart';
// import 'package:http_authentication/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Authenticate();
  }
}

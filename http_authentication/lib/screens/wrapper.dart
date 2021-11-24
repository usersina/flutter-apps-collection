import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_authentication/models/user.dart';
import 'package:http_authentication/screens/authenticate/authenticate.dart';
import 'package:http_authentication/screens/home/home.dart';
import 'package:provider/provider.dart';
// import 'package:http_authentication/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Getting notified!");
    // -- Subscribe to the User provided by the previous widget stream
    final user = Provider.of<User?>(context);
    return user == null ? const Authenticate() : const Home();
  }
}

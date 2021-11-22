import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_products_manager/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in to manage the products"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
          child: const Text("Sign in anonymously"),
          onPressed: () async {
            User? user = await _authService.signInAnon();
            if (user == null) {
              log("Error signing in");
            } else {
              log("Signed in: $user");
            }
          },
        ),
      ),
    );
  }
}

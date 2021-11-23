import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in to get access"),
        actions: [
          TextButton.icon(
            onPressed: () {
              toggleView();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

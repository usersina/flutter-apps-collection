import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an account"),
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
              "Sign in",
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

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          TextButton.icon(
            onPressed: () async {},
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "All clear",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

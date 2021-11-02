import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_products_manager/services/auth_service.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService _authService = AuthService();
  final FireStoreDbService _fireStoreDbService = FireStoreDbService();

  @override
  Widget build(BuildContext context) {
    testProds();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Products Manager"),
      ),
      body: const Text("Base boilerplate"),
    );
  }

  Future testProds() async {
    User? user = await _authService.signInAnon();
    if (user == null) return;

    log(user.uid);
    await _fireStoreDbService.getProducts();
  }
}

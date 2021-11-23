import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_products_manager/screens/authenticate/authenticate.dart';
import 'package:firestore_products_manager/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // -- Listen for auth changes & return either authenticate or home
    return user == null ? const Authenticate() : Home();
  }
}

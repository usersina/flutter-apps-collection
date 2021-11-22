import 'package:firestore_products_manager/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // -- Listen for auth changes & return either authenticate or home
    return const Home();
  }
}

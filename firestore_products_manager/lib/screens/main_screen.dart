import 'dart:developer';

import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:firestore_products_manager/widgets/products_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FireStoreDbService _fireStoreDbService = FireStoreDbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Products Manager"),
      ),
      body: FutureBuilder(
        future: _fireStoreDbService.getProducts(),
        builder: (context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return ProductsList(
              products: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

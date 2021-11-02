import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:firestore_products_manager/widgets/products_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final FireStoreDbService _fireStoreDbService = FireStoreDbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Products Manager"),
      ),
      // -- Using a stream builder will update the UI
      // -- in real-time whenever data is changed in firebase
      body: StreamBuilder(
        stream: _fireStoreDbService.products$,
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

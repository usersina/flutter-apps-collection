import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/auth_service.dart';
import 'package:firestore_products_manager/services/firestore_db_service.dart';
import 'package:firestore_products_manager/widgets/product_dialog.dart';
import 'package:firestore_products_manager/widgets/products_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products Manager"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _authService.signOut();
            },
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
      // -- Using a stream builder will update the UI
      // -- in real-time whenever data is changed in firebase
      body: StreamBuilder(
        stream: FireStoreDbService.products$,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ProductDialog(),
          );
        },
      ),
    );
  }
}

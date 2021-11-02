import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_products_manager/models/product.dart';
import 'package:firestore_products_manager/services/auth_service.dart';

class FireStoreDbService {
  static final AuthService _authService = AuthService();
  static User? user;
  static Future<User?> ensureAuthenticated() async {
    if (FireStoreDbService.user == null) {
      return await _authService.signInAnon();
    }
    return user;
  }

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  Future createProduct(String name, int price) async {
    FireStoreDbService.ensureAuthenticated();
    return await productsCollection.doc().set({
      'name': name,
      'price': price,
    });
  }

  Future<List<Product>> getProducts() async {
    FireStoreDbService.ensureAuthenticated();
    QuerySnapshot snapshot = await productsCollection.get();
    return snapshot.docs
        .map((doc) => Product(doc["name"], doc["price"]))
        .toList();
  }
}

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

  static final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection("products");

  static Future createProduct(String name, int price) async {
    FireStoreDbService.ensureAuthenticated();
    return await productsCollection.doc().set({
      'name': name,
      'price': price,
    });
  }

  static Future updateProduct(String id, String name, int price) async {
    FireStoreDbService.ensureAuthenticated();
    return await productsCollection.doc(id).set({
      'name': name,
      'price': price,
    });
  }

  static Future deleteProduct(String id) async {
    return await productsCollection.doc(id).delete();
  }

  // Get products stream
  static Stream<List<Product>> get products$ {
    return productsCollection.snapshots().map(_productsListFromSnapshot);

    // return productsCollection.snapshots().map(
    //       (snapshot) => snapshot.docs
    //           .map((doc) => Product(doc.id, doc["name"], doc["price"]))
    //           .toList(),
    //     );
  }

  // ----- Mappers -----
  static List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(doc.id, doc["name"], doc["price"]))
        .toList();
  }
}

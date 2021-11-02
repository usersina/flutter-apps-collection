import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreDbService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  Future<List<dynamic>> getProducts() async {
    return [];
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User change auth stream
  Stream<User?> get user$ {
    return _auth.authStateChanges();
  }

  // Sign in anonymously
  Future<User?> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      log("singInAnon: " + e.toString());
      return null;
    }
  }

  // Sign in with email & password

  // Register with email & password
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log("registerWithEmailAndPassword: " + e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log("signOut: " + e.toString());
      return null;
    }
  }
}

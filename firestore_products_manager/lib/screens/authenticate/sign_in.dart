import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_products_manager/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  bool _enableAutoValidation = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in to get access"),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            autovalidateMode: _enableAutoValidation
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (String? value) {
                    if (value == null) return "";

                    if (value.isEmpty || !value.contains("@")) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _enableAutoValidation = true;
                    });
                    if (_formKey.currentState == null) return;

                    if (_formKey.currentState!.validate()) {
                      UserCredential? result = await _authService.signIn(
                          _emailController.text, _passwordController.text);
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Clould not log in with these credentials!',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Sign in",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

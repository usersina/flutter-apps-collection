import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_authentication/models/user.dart';
import 'package:http_authentication/providers/user_provider.dart';
import 'package:http_authentication/services/http_service.dart';
import 'package:http_authentication/shared/constants.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final HttpService _httpService = HttpService();

  final _formKey = GlobalKey<FormState>();
  bool _enableAutoValidation = false;
  // bool loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an account"),
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
              "Sign in",
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
                  decoration: textInputDecoration.copyWith(
                    hintText: "Enter your email",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null) return "";

                    if (value.isEmpty || value.length < 3) {
                      return "Password should have 3 characters minimum";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    hintText: "Enter your password",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null) return "";

                    if (value.isEmpty || value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    hintText: "Confirm your password",
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
                      dynamic res =
                          await _httpService.registerWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );
                      log(res);
                      if (res != null) {
                        try {
                          _userProvider.setNextStreamValue(
                            User.fromMap(
                              json.decode(res),
                            ),
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Register",
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

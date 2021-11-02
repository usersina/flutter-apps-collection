import 'dart:developer';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? rawData;

  @override
  void initState() {
    super.initState();
    readJsonFile();
    // -- https://stackoverflow.com/questions/58400001/should-i-call-super-initstate-at-the-end-or-at-the-beginning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JSON Handler"),
      ),
      body: Text(
        rawData != null ? rawData! : "",
      ),
    );
  }

  Future readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context).loadString(
      "assets/pizzalist.json",
    );
    setState(() {
      rawData = myString;
    });
  }
}

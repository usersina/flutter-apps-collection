import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_handler/models/pizza.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Pizza>? pizzas;

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
      body: pizzas == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pizzas!.length,
              itemBuilder: (BuildContext context, int idx) {
                Pizza pizza = pizzas![idx];
                return ListTile(
                  title: Text(pizza.pizzaName),
                  subtitle: Text(
                    pizza.description + " -\$" + pizza.price.toString(),
                  ),
                );
              },
            ),
    );
  }

  Future readJsonFile() async {
    String myString = await DefaultAssetBundle.of(context).loadString(
      "assets/pizzalist.json",
    );
    List rawResult = jsonDecode(myString);
    List<Pizza> myPizzas = rawResult
        .map(
          (item) => Pizza.fromMap(item),
        )
        .toList();
    setState(() {
      pizzas = myPizzas;
    });
  }
}

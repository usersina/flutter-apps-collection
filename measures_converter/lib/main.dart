import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double? _numberFrom;
  String _selectedFrom = 'grams';
  String _selectedTo = 'kilograms';

  // -- Mass conversions from a base of 1 gram
  final Map<String, double> _massConvertions = {
    'grams': 1,
    'kilograms': 1 / 1000,
    'pounds (lb.)': 1 / 454,
    'ounces': 1 / 28.35
  };

  // -- The conversion formula
  double calculateResult(double value) {
    log("Multiplying by " + _massConvertions[_selectedTo]!.toString());
    log("Dividing by " + _massConvertions[_selectedFrom]!.toString());
    return value *
        (_massConvertions[_selectedTo]! / _massConvertions[_selectedFrom]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Measures Converter"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            children: [
              const Text(
                'Value to convert',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'e.g. 5126'),
                onChanged: (text) {
                  var value = double.tryParse(text);
                  setState(() {
                    if (value == null) {
                      _numberFrom = 0;
                      return;
                    }
                    _numberFrom = calculateResult(value);
                  });
                },
              ),
              const SizedBox(height: 15),
              DropdownButton<String>(
                value: _selectedFrom,
                isExpanded: true,
                items: _massConvertions.entries
                    .map((MapEntry<String, double> mapEntry) {
                  return DropdownMenuItem(
                    child: Text(mapEntry.key),
                    value: mapEntry.key,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrom = value as String;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedTo,
                isExpanded: true,
                items: _massConvertions.entries
                    .map((MapEntry<String, double> mapEntry) {
                  return DropdownMenuItem(
                    child: Text(mapEntry.key),
                    value: mapEntry.key,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTo = value as String;
                  });
                },
              ),
              const SizedBox(height: 30),
              Text(
                (_numberFrom == null || _numberFrom == 0)
                    ? ''
                    : _numberFrom!.toStringAsFixed(3),
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}

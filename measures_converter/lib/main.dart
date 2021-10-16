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
  final List<String> _measures = [
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lb.)',
    'ounces',
  ];
  double? _numberFrom;
  String _selectedFrom = 'grams';
  String _selectedTo = 'kilograms';

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
                  if (value != null) {
                    setState(() {
                      _numberFrom = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 15),
              DropdownButton<String>(
                value: _selectedFrom,
                isExpanded: true,
                items: _measures.map((String measure) {
                  return DropdownMenuItem(value: measure, child: Text(measure));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrom = value as String;
                  });
                  log("Selected value is: " + _selectedFrom);
                },
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedTo,
                isExpanded: true,
                items: _measures.map((String measure) {
                  return DropdownMenuItem(value: measure, child: Text(measure));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTo = value as String;
                  });
                  log("Selected value is: " + _selectedTo);
                },
              ),
              const SizedBox(height: 30),
              Text(
                (_numberFrom == null) ? '' : _numberFrom.toString(),
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
      ),
    );
  }
}

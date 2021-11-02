import 'package:flutter/material.dart';
import 'package:json_handler/screens/filesystem_screen.dart';
// import 'package:json_handler/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JSON Handler",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: const MainScreen(),
      home: const FileSystemScreen(),
    );
  }
}

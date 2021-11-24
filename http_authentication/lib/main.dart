import 'package:flutter/material.dart';
import 'package:http_authentication/models/user.dart';
import 'package:http_authentication/providers/user_provider.dart';
import 'package:http_authentication/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return StreamProvider<User?>.value(
      initialData: null,
      value: _userProvider.loggedUser$,
      child: MaterialApp(
        title: "HTTP Authentication",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const Wrapper(),
      ),
    );
  }
}

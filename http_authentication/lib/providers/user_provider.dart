import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http_authentication/models/user.dart';

class UserProvider extends ChangeNotifier {
  final _streamController = StreamController<User?>();

  Stream<User?> get loggedUser$ {
    return _streamController.stream;
  }

  setNextStreamValue(User? user) {
    _streamController.add(user);
  }
}

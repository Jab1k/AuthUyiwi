import 'package:flutter/material.dart';
import 'package:flutter_application_18/model/model.dart';

class Controller extends ChangeNotifier {
  AppModel? userdata = AppModel();

  String? name, email, avatar;
  String? name1, email1, avatar1;

  changeUserdata(AppModel newuser) {
    userdata = newuser;
    notifyListeners();
  }

  addUserInfo(String name1, email1, avatar1) {
    name = name1;
    email = email1;
    avatar = avatar1;
    notifyListeners();
  }
}

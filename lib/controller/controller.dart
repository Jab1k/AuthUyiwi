import 'package:flutter/material.dart';
import 'package:flutter_application_18/model/model.dart';

class Controller extends ChangeNotifier {
  AppModel? userdata = AppModel();

  changeUserdata(AppModel newuser) {
    userdata = newuser;
    notifyListeners();
  }
}

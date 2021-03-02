import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../utils/functions.dart' as Functions;
import '../utils/constants.dart' as MyConstants;
import 'field_data.dart';

class AccountData extends ChangeNotifier {
  String accountName;
  FieldData email;
  FieldData password;
  List<FieldData> allFields = [];
  Widget icon;

  // final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  bool isShowButtonPressed = false;
  bool isEditButtonPressed = false;

  AccountData(
      {@required this.accountName, this.email, this.password, this.icon}) {
    this.email = email ?? FieldData(name: "Password", value: "");
    this.password = password ?? FieldData(name: "Email", value: "");
    allFields.addAll([this.email, this.password]);

    if (icon == null) {
      this.icon = Functions.generateRandomColorIcon(
          name: accountName, color: MyConstants.iconDefaultColors[0]);
    }
  }

  void addField({String name, String value}) {
    allFields.add(FieldData(name: name, value: value));

    notifyListeners();
  }

  void removeFieldAt(int index) {
    allFields.removeAt(index);
    notifyListeners();
  }

  void pressShowButton() {
    isShowButtonPressed = !isShowButtonPressed;
    notifyListeners();
  }

  void pressEditButton() {
    isEditButtonPressed = !isEditButtonPressed;
    notifyListeners();
  }

  int get getNumberOfFields => allFields.length;


  static bool isNameUsed(
      {@required List<AccountData> accounts, @required String name}) {
    bool isUsed = false;
    for (var el in accounts) {
      if (el.accountName.toLowerCase() == name.toLowerCase()) {
        isUsed = true;
        break;
      }
    }
    return isUsed;
  }
}


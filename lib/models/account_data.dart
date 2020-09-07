import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../utils/functions.dart' as Functions;
import '../utils/constants.dart' as MyConstants;

class AccountData extends ChangeNotifier {
  String accountName;
  FieldData email;
  FieldData password;
  List<FieldData> additionalFields = [];
  Widget icon;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  AccountData(
      {@required this.accountName, this.email, this.password, this.icon}) {
    this.email = email ?? FieldData(name: "Password", value: "");
    this.password = password ?? FieldData(name: "Email", value: "");
    if (icon == null) {
      this.icon = Functions.generateRandomColorIcon(
          name: accountName, color: MyConstants.iconDefaultColors[0]);
    }
  }

  void addField({String name, String value}) {
    additionalFields.add(FieldData(name: name, value: value));
    notifyListeners();
  }

  void removeFieldAt(int index) {
    additionalFields.removeAt(index);
    notifyListeners();
  }

  List<FieldData> get getAdditionalFields => additionalFields;

  int get getNumberOfFields => additionalFields.length + 2;

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

class FieldData {
  String name;
  String value;

  FieldData({
    this.name,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory FieldData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FieldData(
      name: map['name'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FieldData.fromJson(String source) =>
      FieldData.fromMap(json.decode(source));
}

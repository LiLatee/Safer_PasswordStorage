import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../utils/functions.dart' as Functions;

class AccountData {
  String accountName;
  FieldData email;
  FieldData password;
  List<FieldData> additionalFields = [];
  Widget icon;

  AccountData(
      {@required this.accountName,
      this.email,
      this.password,
      @required this.icon}) {
    this.email = FieldData(name: "Password", value: "");
    this.password = FieldData(name: "Email", value: "");
    if (icon == null) {
      this.icon = Functions.generateRandomColorIcon(name: accountName);
    }
  }

  void addField({String name, String value}) {
    additionalFields.add(FieldData(name: name, value: value));
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

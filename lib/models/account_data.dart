import 'dart:convert';
import 'package:flutter/cupertino.dart';

class AccountData {
  String accountName;
  Field email;
  Field password;
  List<Field> additionalFields = [];

  AccountData({@required this.accountName, this.email, this.password});

  void addField({String name, String value}) {
    additionalFields.add(Field(name: name, value: value));
  }

  Map<String, String> getMapOfAdditionalFields() {}
}

class Field {
  String name;
  String value;

  Field({
    this.name,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory Field.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Field(
      name: map['name'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Field.fromJson(String source) => Field.fromMap(json.decode(source));
}

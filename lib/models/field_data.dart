import 'dart:convert';

import 'package:flutter/material.dart';

class FieldData {
  UniqueKey uniqueKey;
  String name;
  String value;

  FieldData({
    uniqueKey,
    required this.name,
    required this.value,
  }) : this.uniqueKey = UniqueKey();

  Map<String, dynamic> toMap() {
    return {
      'uniqueKey': uniqueKey,
      'name': name,
      'value': value,
    };
  }

  factory FieldData.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return FieldData(
      uniqueKey: map['uniqueKey'],
      name: map['name'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FieldData.fromJson(String source) =>
      FieldData.fromMap(json.decode(source));
}
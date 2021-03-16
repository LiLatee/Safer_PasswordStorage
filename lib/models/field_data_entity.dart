import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:uuid/uuid.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['accountId'],
      parentColumns: ['uuid'],
      entity: AccountDataEntity,
    ),
  ],
  // primaryKeys: ['uuid'],
)
class FieldDataEntity {
  @primaryKey
  String? uuid;

  final String accountId;
  String name;
  String value;
  bool isHidden;
  bool isMultiline;
  int position;

  FieldDataEntity({
    this.uuid,
    required this.accountId,
    required this.name,
    required this.value,
    this.isHidden = false,
    this.isMultiline = false,
    this.position = 0, // TODO
  }) {
    if (this.uuid == null)
      this.uuid = Uuid().v1();
  }
}

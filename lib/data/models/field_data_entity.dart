import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'account_data_entity.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['accountId'],
      parentColumns: ['uuid'],
      entity: AccountDataEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class FieldDataEntity extends Equatable {
  @PrimaryKey()
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
    if (this.uuid == null) this.uuid = Uuid().v1();
  }

  @override
  String toString() {
    return '''FieldDataEntity(
        uuid: $uuid, accountId: $accountId, 
        name: $name, value: $value,
        isHidden: $isHidden, isMultiline: $isMultiline, position: $position
    )''';
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [uuid, accountId, name, value, isHidden, isMultiline, position];
}

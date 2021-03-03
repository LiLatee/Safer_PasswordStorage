import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';

@Entity(foreignKeys: [
  ForeignKey(
    childColumns: ['accountId'],
    parentColumns: ['id'],
    entity: AccountDataEntity,
  ),
])
class FieldDataEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int accountId;
  String name;
  String value;
  int position;

  FieldDataEntity({
    this.id,
    this.accountId,
    this.name,
    this.value,
    this.position,
  });

}

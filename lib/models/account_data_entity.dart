import 'dart:convert';
import 'dart:developer';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysimplepasswordstorage/models/database.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import '../utils/functions.dart' as Functions;
import '../utils/constants.dart' as MyConstants;
import 'field_data.dart';

// @Entity(
//   indices: [
//     Index(
//       value: ['accountName'],
//       unique: true,
//     ),
//   ],
// )
@entity
class AccountDataEntity {
  @PrimaryKey(autoGenerate: true)
  final int id;
  // @ColumnInfo(nullable: false)
  String accountName;

  // Widget icon;
  int isShowButtonPressed;
  int isEditButtonPressed;

  // final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  AccountDataEntity({
    this.id,
    this.accountName,
    this.isEditButtonPressed = 0,
    this.isShowButtonPressed = 0,
  });


  void addField({AppDatabase db, String name, String value}) {
    // allFields.add(FieldData(name: name, value: value));
    db.fieldDao.insertField(FieldDataEntity(name: name, value: value, accountId: this.id ));
    // notifyListeners();
  }

  // void removeFieldAt({AppDatabase db, int index}) {
  //   // allFields.removeAt(index);
  //   db.fieldDao.removeFieldAt(index);
  //   // notifyListeners();
  // }

}

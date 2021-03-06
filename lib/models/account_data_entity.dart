import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';
import 'dart:typed_data';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  int isShowButtonPressed;
  int isEditButtonPressed;

  // bool isImage;
  @ignore
  Widget iconWidget;
  Uint8List iconImage;
  String iconColorHex;

  // String iconText;

  @ignore
  List<FieldDataEntity> fields;

  // final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  AccountDataEntity({
    this.id,
    this.accountName,
    this.isEditButtonPressed = 0,
    this.isShowButtonPressed = 0,
    this.iconImage,
    this.iconColorHex,
    // this.iconText,
    fields,
  }) {
    this.fields = fields ?? [];

    // if (iconColorHEX is Color)
    //   this.iconColorHex = iconColorHEX.value.toRadixString(16);
    // else
    //   this.iconColorHex = iconColorHEX;

    /// Setting [icon] widget. Generate widget with [iconColorHex] or with random color.
    if (iconWidget == null) setIconWidget();
  }

  void setIconWidget() {
    /// Prefer using [iconImage] than [iconColorHex].
    if (this.iconImage != null) {
      this.iconWidget = Functions.buildCircleAvatarUsingImage(
        imageForIcon: Image.memory(
          this.iconImage,
          width: MyConstants.defaultCircularBorderRadius * 2,
          height: MyConstants.defaultCircularBorderRadius * 2,
        ),
      );
    } else {
      this.iconColorHex ??= MyConstants
          .iconDefaultColors[
              Random().nextInt(MyConstants.iconDefaultColors.length)]
          .value
          .toRadixString(16);

      this.iconWidget = Functions.generateRandomColorIcon(
        name: accountName,
        color: Functions.HexColor.fromHex(this.iconColorHex),
      );
    }
  }
}

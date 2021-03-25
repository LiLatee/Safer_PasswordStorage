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
import '../utils/AppConstants.dart' as MyConstants;
import 'field_data.dart';
import 'package:uuid/uuid.dart';

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
  @primaryKey
  String? uuid;

  String accountName;
  Uint8List? iconImage;
  String? iconColorHex;

  @ignore
  bool isShowButtonPressed;
  @ignore
  bool isEditButtonPressed;
  @ignore
  Widget? iconWidget;
  @ignore
  List<FieldDataEntity> fields;

  // final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  AccountDataEntity({
    this.uuid,
    required this.accountName,
    this.isEditButtonPressed = false,
    this.isShowButtonPressed = false,
    this.iconImage,
    this.iconColorHex,
    // this.iconText,
    fields,
  }) : fields = fields ?? [] {

    if (this.uuid == null)
      this.uuid = Uuid().v1();

    // if (iconColorHEX is Color)
    //   this.iconColorHex = iconColorHEX.value.toRadixString(16);
    // else
    //   this.iconColorHex = iconColorHEX;

    /// Setting [icon] widget. Generate widget with [iconColorHex] or with random color.
    if (iconWidget == null) setIconWidget();
  }

  int getNextFieldPosition() {
    int currentMaxPosition = -1;
    for (var field in fields) {
      if (field.position > currentMaxPosition)
        currentMaxPosition = field.position;
    }
    return currentMaxPosition + 1;
  }

  void setIconWidget() {
    /// Prefer using [iconImage] than [iconColorHex].
    if (this.iconImage != null) {
      this.iconWidget = Functions.buildCircleAvatarUsingImage(
        imageForIcon: Image.memory(
          this.iconImage!,
          width: MyConstants.defaultCircularBorderRadius * 2,
          height: MyConstants.defaultCircularBorderRadius * 2,
        ),
      );
    } else {
      this.iconColorHex ??= MyConstants
          .iconDefaultColors[0]
          .value
          .toRadixString(16);

      this.iconWidget = Functions.generateRandomColorIconAsWidget(
        name: accountName,
        color: Functions.HexColor.fromHex(this.iconColorHex!),
      );
    }
  }
}

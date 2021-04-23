import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/AppConstants.dart' as AppConstants;
import '../../core/constants/AppFunctions.dart' as AppFunctions;
import 'field_data_entity.dart';

@entity
class AccountDataEntity extends Equatable {
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

  AccountDataEntity({
    this.uuid,
    required this.accountName,
    this.isEditButtonPressed = false,
    this.isShowButtonPressed = false,
    this.iconImage,
    this.iconColorHex,
    fields,
  }) : fields = fields ?? [] {
    if (this.uuid == null) this.uuid = Uuid().v1();

    /// Setting [icon] widget. Generate widget with [iconColorHex] or with random color.
    if (iconWidget == null) setIconWidget();
  }

  void setIconWidget() {
    /// Prefer using [iconImage] than [iconColorHex].
    if (this.iconImage != null) {
      this.iconWidget = AppFunctions.buildCircleAvatarUsingImage(
        imageForIcon: Image.memory(
          this.iconImage!,
          width: AppConstants.defaultIconRadius * 2,
          height: AppConstants.defaultIconRadius * 2,
        ),
      );
    } else {
      this.iconColorHex ??=
          AppConstants.iconDefaultColors[0].value.toRadixString(16);

      this.iconWidget = AppFunctions.generateRandomColorIconAsWidget(
        name: accountName,
        color: AppFunctions.HexColor.fromHex(this.iconColorHex!),
      );
    }
  }

  AccountDataEntity copyWith({
    String? uuid,
    String? accountName,
    Uint8List? iconImage,
    String? iconColorHex,
    bool? isShowButtonPressed,
    bool? isEditButtonPressed,
    List<FieldDataEntity>? fields,
  }) {
    var temp = AccountDataEntity(
      uuid: uuid ?? this.uuid,
      accountName: accountName ?? this.accountName,
      iconImage: iconImage ?? this.iconImage,
      iconColorHex: iconColorHex ?? this.iconColorHex,
      isShowButtonPressed: isShowButtonPressed ?? this.isShowButtonPressed,
      isEditButtonPressed: isEditButtonPressed ?? this.isEditButtonPressed,
      fields: fields ?? <FieldDataEntity>[],
    );

    temp.iconWidget = this.iconWidget;
    if (fields == null)
      for (var field in this.fields) temp.fields.add(field.copyWith());

    return temp;
  }

  @override
  String toString() {
    return '''AccountDataEntity(
        uuid: $uuid, accountName: $accountName,
        iconColorHex: $iconColorHex, isShowButtonPressed: $isShowButtonPressed, isEditButtonPressed: $isEditButtonPressed,
        iconWidget: $iconWidget, 
        fields: $fields
      )''';
  }

  @override
  List<Object?> get props => [
        uuid,
        accountName,
        iconColorHex,
        isEditButtonPressed,
        isShowButtonPressed,
        iconWidget,
        fields
      ];
}

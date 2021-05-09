import 'dart:developer';
import 'dart:typed_data';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:encrypt/encrypt.dart' as enc;

import '../../core/constants/AppConstants.dart';
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

  AccountDataEntity encrypt({required String key}) {
    final aesKey = enc.Key.fromBase64(key);
    final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    List<FieldDataEntity> encryptedFields =
        this.fields.map((e) => e.encrypt(key: key)).toList();

    return this.copyWith(
      accountName: encrypter.encrypt(this.accountName, iv: iv).base64,
      // iconImage: encrypter.encryptBytes(this.iconImage!, iv: iv).bytes,
      fields: encryptedFields,
    );
  }

  AccountDataEntity decrypt({required String key}) {
    final aesKey = enc.Key.fromBase64(key);
    final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    List<FieldDataEntity> encryptedFields =
        this.fields.map((e) => e.decrypt(key: key)).toList();

    return this.copyWith(
      accountName:
          encrypter.decrypt(enc.Encrypted.fromBase64(this.accountName), iv: iv),
      // iconImage: encrypter.decryptBytes(enc.Encrypted.fromUtf8(Utf8Decoder().convert(this.iconImage!)), iv: iv),
      fields: encryptedFields,
    );
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

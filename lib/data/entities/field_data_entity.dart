import 'package:encrypt/encrypt.dart' as enc;
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
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
    this.position = 0,
  }) {
    if (this.uuid == null) this.uuid = Uuid().v1();
  }

  FieldDataEntity encrypt({required String key}) {
    final aesKey = enc.Key.fromBase64(key);
    final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    return this.copyWith(
      name: encrypter.encrypt(this.name, iv: iv).base64,
      value:
          this.value != '' ? encrypter.encrypt(this.value, iv: iv).base64 : '',
    );
  }

  FieldDataEntity decrypt({required String key}) {
    final aesKey = enc.Key.fromBase64(key);
    final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    return this.copyWith(
      name: encrypter.decrypt(enc.Encrypted.fromBase64(this.name), iv: iv),
      value: this.value != ''
          ? encrypter.decrypt(enc.Encrypted.fromBase64(this.value), iv: iv)
          : '',
    );
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
  List<Object?> get props =>
      [uuid, accountId, name, value, isHidden, isMultiline, position];

  FieldDataEntity copyWith({
    String? uuid,
    String? accountId,
    String? name,
    String? value,
    bool? isHidden,
    bool? isMultiline,
    int? position,
  }) {
    return FieldDataEntity(
      uuid: uuid ?? this.uuid,
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      value: value ?? this.value,
      isHidden: isHidden ?? this.isHidden,
      isMultiline: isMultiline ?? this.isMultiline,
      position: position ?? this.position,
    );
  }
}

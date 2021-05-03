import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:uuid/uuid.dart';
import 'package:encrypt/encrypt.dart' as enc;

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
    final aesKey = enc.Key.fromUtf8(key);
    // final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    return this.copyWith(
      name: encrypter.encrypt(this.name).toString(),
      value: encrypter.encrypt(this.value).toString(),
    );
  }

  FieldDataEntity decrypt({required String key}) {
    final aesKey = enc.Key.fromUtf8(key);
    // final iv = enc.IV.fromLength(16);
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(aesKey));

    return this.copyWith(
      name: encrypter.decrypt(enc.Encrypted.fromUtf8(this.name)),
      value: encrypter.decrypt(enc.Encrypted.fromUtf8(this.value)),
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

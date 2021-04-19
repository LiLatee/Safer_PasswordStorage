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
  late String uuid;

  final String accountId;
  String name;
  String value;
  bool isHidden;
  bool isMultiline;
  int position;

  FieldDataEntity({
    uuid,
    required this.accountId,
    required this.name,
    required this.value,
    this.isHidden = false,
    this.isMultiline = false,
    this.position = 0, // TODO
  }) {
    this.uuid = uuid ?? Uuid().v1();
    // if (this.uuid == null) this.uuid = Uuid().v1();
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

part of 'single_account_cubit.dart';

@immutable
abstract class SingleAccountState extends Equatable {
  get accountDataEntity => accountDataEntity;
}

class SingleAccountStateReading extends SingleAccountState {
  final AccountDataEntity accountDataEntity;

  SingleAccountStateReading({required this.accountDataEntity});

  @override
  String toString() {
    return accountDataEntity.toString();
  }

  @override
  List<Object?> get props => [accountDataEntity];
}

// class SingleAccountStateEditing extends SingleAccountState {
//   final AccountDataEntity accountDataEntity;
//   final AccountDataEntity accountDataEntityChanged;

//   SingleAccountStateEditing(
//       {required this.accountDataEntity,
//       required this.accountDataEntityChanged});

//   @override
//   List<Object?> get props => [accountDataEntity, accountDataEntityChanged];
// }

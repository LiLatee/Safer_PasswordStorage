part of 'single_account_cubit.dart';

class SingleAccountState extends Equatable {
//   final AccountDataEntity accountDataEntity;

//   SingleAccountState(this.accountDataEntity);
// }

// class SingleAccountInitial extends SingleAccountState {
//
  final AccountDataEntity accountDataEntity;

  SingleAccountState({required this.accountDataEntity});

  @override
  String toString() {
    return accountDataEntity.toString();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [accountDataEntity];
}

part of 'single_account_cubit.dart';

@immutable
abstract class SingleAccountState extends Equatable {
  get accountDataEntity => accountDataEntity;
}

class SingleAccountReadingState extends SingleAccountState {
  final AccountDataEntity accountDataEntity;

  SingleAccountReadingState({required this.accountDataEntity});

  @override
  String toString() {
    return accountDataEntity.toString();
  }

  @override
  List<Object?> get props => [accountDataEntity];
}

part of 'accounts_cubit.dart';

@immutable
abstract class AccountsState {
  final List<AccountDataEntity> accountDataList;

  AccountsState({required this.accountDataList});
}

class AccountsLoading extends AccountsState {
  AccountsLoading({required accountDataList})
      : super(accountDataList: accountDataList);
}

class AccountsLoaded extends AccountsState {
  AccountsLoaded({required accountDataList})
      : super(accountDataList: accountDataList);
}

class AccountsImported extends AccountsState {
  AccountsImported({required accountDataList})
      : super(accountDataList: accountDataList);
}

class AccountsExported extends AccountsState {
  AccountsExported({required accountDataList})
      : super(accountDataList: accountDataList);
}

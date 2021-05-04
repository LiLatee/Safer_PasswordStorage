import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';

import 'accounts_cubit.dart';

part 'delete_account_cubit_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountCubitState> {
  final AccountsRepository accountsRepository;
  final AccountsCubit accountsCubit;

  DeleteAccountCubit({
    required this.accountsRepository,
    required this.accountsCubit,
  }) : super(DeleteAccountCubitInitial());

  Future<void> deleteAccount(
      {required AccountDataEntity accountDataEntity}) async {
    emit(DeletingAccount());

    var failureOrSuccess =
        await accountsRepository.deleteAccount(accountData: accountDataEntity);

    failureOrSuccess.fold(
      (failure) => null,
      (success) async {
        accountsCubit.deleteAccount(accountData: accountDataEntity);

        var failureOrAllAccounts = await accountsRepository.getAllAccounts();
        failureOrAllAccounts.fold(
          (failure) => null,
          (allAccounts) => emit(DeletedAccount()),
        );
      },
    );
  }
}

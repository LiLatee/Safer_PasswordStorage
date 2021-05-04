import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';

import 'accounts_cubit.dart';

part 'add_account_state.dart';

class AddAccountCubit extends Cubit<AddAccountState> {
  final AccountsRepository accountsRepository;
  final AccountsCubit accountsCubit;

  AddAccountCubit({
    required this.accountsRepository,
    required this.accountsCubit,
  }) : super(AddAccountInitial());

  Future<void> addAccount({required AccountDataEntity accountData}) async {
    emit(Adding());

    var failureOrSuccess =
        await accountsRepository.addAccount(accountData: accountData);

    failureOrSuccess.fold(
      (failure) => null,
      (success) async {
        accountsCubit.addAccount(accountData: accountData);
        var failureOrAllAccounts = await accountsRepository.getAllAccounts();

        failureOrAllAccounts.fold(
          (failure) => null,
          (allAccounts) => emit(AddedAccount()),
        );
      },
    );
  }
}

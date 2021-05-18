import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/entities/account_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';

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
      (failure) => null, // TODO
      (success) async {
        accountsCubit.deleteAccount(accountData: accountDataEntity);

        var failureOrAllAccounts = await accountsRepository.getAllAccounts();
        failureOrAllAccounts.fold(
          (failure) => null, // TODO
          (allAccounts) => emit(DeletedAccount()),
        );
      },
    );
  }
}

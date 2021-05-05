import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/account_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';

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
    emit(AddingAccount());

    var failureOrSuccess =
        await accountsRepository.addAccount(accountData: accountData);

    failureOrSuccess.fold(
      (failure) => null, // TODO
      (success) async {
        accountsCubit.addAccount(accountData: accountData);
        var failureOrAllAccounts = await accountsRepository.getAllAccounts();

        failureOrAllAccounts.fold(
          (failure) => null, // TODO
          (allAccounts) => emit(AddedAccount()),
        );
      },
    );
  }
}

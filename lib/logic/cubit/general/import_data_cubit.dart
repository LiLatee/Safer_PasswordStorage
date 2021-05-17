import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/data/database/app_secret_key_dao.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/app_key_cubit.dart';
import '../../../data/repositories/accounts_repository.dart';
import '../all_accounts/accounts_cubit.dart';

part 'import_data_state.dart';

class ImportDataCubit extends Cubit<ImportDataState> {
  final AccountsRepository accountsRepository;
  final AccountsCubit accountsCubit;
  final AppKeyCubit appKeyCubit;

  ImportDataCubit({
    required this.accountsCubit,
    required this.accountsRepository,
    required this.appKeyCubit,
  }) : super(ImportDataInitial());

  @override
  void onChange(Change<ImportDataState> change) {
    super.onChange(change);
    print(
        'AuthCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  Future<void> importData(
      {required String secretKey, required String filepath}) async {
    emit(ImportingData());
    // await Future.delayed(Duration(seconds: 3));
    var failureOrSuccess = await accountsRepository.importEncryptedDatabase(
        secretKey: secretKey, filepath: filepath, appKeyCubit: appKeyCubit);

    failureOrSuccess.fold(
      (failure) => emit(ImportError()),
      (success) {
        accountsCubit.fetchData();
        emit(ImportedData());
      },
    );
  }
}

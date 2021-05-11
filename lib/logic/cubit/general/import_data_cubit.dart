import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/accounts_repository.dart';
import '../all_accounts/accounts_cubit.dart';

part 'import_data_state.dart';

class ImportDataCubit extends Cubit<ImportDataState> {
  final AccountsRepository accountsRepository;
  final AccountsCubit accountsCubit;

  ImportDataCubit(
      {required this.accountsCubit, required this.accountsRepository})
      : super(ImportDataInitial());

  Future<void> importData(
      {required String secretKey, required String filepath}) async {
    var failureOrSuccess = await accountsRepository.importEncryptedDatabase(
        secretKey: secretKey, filepath: filepath);

    failureOrSuccess.fold(
      (failure) => emit(ImportError()),
      (success) {
        accountsCubit.fetchData();
        emit(ImportedData());
      },
    );
  }
}

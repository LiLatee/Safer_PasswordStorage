import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/repositories/accounts_repository.dart';

part 'export_data_state.dart';

class ExportDataCubit extends Cubit<ExportDataState> {
  final AccountsRepository accountsRepository;

  ExportDataCubit({required this.accountsRepository})
      : super(ExportDataInitial());

  Future<void> exportData({required String secretKey}) async {
    emit(ExportingData());
    var failureOrSuccess =
        await accountsRepository.exportEncryptedDatabase(secretKey: secretKey);

    failureOrSuccess.fold(
      (failure) => emit(ExportError(message: failure.toString())),
      (success) => emit(ExportedData(exportedDataLocation: success)),
    );
  }
}

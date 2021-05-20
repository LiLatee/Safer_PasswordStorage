import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/entities/field_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';
import 'single_account_cubit.dart';

part 'delete_field_state.dart';

class DeleteFieldCubit extends Cubit<DeleteFieldState> {
  final AccountsRepository accountsRepository;
  final SingleAccountCubit singleAccountCubit;

  DeleteFieldCubit({
    required this.accountsRepository,
    required this.singleAccountCubit,
  }) : super(DeleteFieldInitial());

  Future<void> deleteField({required FieldDataEntity fieldDataEntity}) async {
    log("DeleteFieldCubit");
    emit(DeletingField());
    await accountsRepository.deleteField(fieldData: fieldDataEntity);

    singleAccountCubit.deleteField(fieldData: fieldDataEntity);
    emit(DeletedField());
  }
}

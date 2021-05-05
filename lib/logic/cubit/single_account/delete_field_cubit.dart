import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/single_account_cubit.dart';

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

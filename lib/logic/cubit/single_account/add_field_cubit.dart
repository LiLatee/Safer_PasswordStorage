import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/single_account_cubit.dart';

part 'add_field_state.dart';

class AddFieldCubit extends Cubit<AddFieldState> {
  final AccountsRepository accountsRepository;
  final SingleAccountCubit singleAccountCubit;

  AddFieldCubit({
    required this.accountsRepository,
    required this.singleAccountCubit,
  }) : super(AddFieldInitial());

  Future<void> addField({required FieldDataEntity fieldDataEntity}) async {
    log("AddFieldCubit");
    emit(AddingField());
    await accountsRepository.addField(fieldData: fieldDataEntity);
    singleAccountCubit.addField(fieldData: fieldDataEntity);
    emit(AddedField());
  }
}

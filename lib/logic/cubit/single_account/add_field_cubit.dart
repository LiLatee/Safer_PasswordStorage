import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/field_data_entity.dart';
import '../../../data/repositories/accounts_repository.dart';
import 'single_account_cubit.dart';

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

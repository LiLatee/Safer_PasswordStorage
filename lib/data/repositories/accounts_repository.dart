import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../core/errors/failures.dart';
import '../../logic/cubit/app_key_cubit.dart';
import '../../service_locator.dart';
import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';

abstract class AccountsRepository {
  //! Accounts

  @nonVirtual
  Future<Either<Failure, void>> addAccount(
      {required AccountDataEntity accountData}) {
    var accountDataEncrypted =
        accountData.encrypt(key: sl<AppKeyCubit>().getKey());
    return addAccountLogic(accountData: accountDataEncrypted);
  }

  Future<Either<Failure, void>> addAccountLogic(
      {required AccountDataEntity accountData});

  Future<Either<Failure, void>> updateAccount(AccountDataEntity accountData);

  Future<Either<Failure, void>> deleteAccount(
      {required AccountDataEntity accountData});

  @nonVirtual
  Future<Either<Failure, List<AccountDataEntity>>> getAllAccounts() async {
    var failureOrAccounts = await getAllAccountsLogic();
    return failureOrAccounts.fold(
      (failure) => Left(SqlLiteFailure()),
      (accounts) {
        var decryptedAccounts = accounts.map(
          (e) {
            var acc = e.decrypt(key: sl<AppKeyCubit>().getKey());
            acc.setIconWidget();
            return acc;
          },
        ).toList();
        return Right(decryptedAccounts);
      },
    );
  }

  Future<Either<Failure, List<AccountDataEntity>>> getAllAccountsLogic();

  Future<Either<Failure, AccountDataEntity?>> getAccountById(String uuid);

  //! Single account operations
  @nonVirtual
  Future<Either<Failure, void>> addField({required FieldDataEntity fieldData}) {
    var fieldDataEncrypted = fieldData.encrypt(key: sl<AppKeyCubit>().getKey());
    return addFieldLogic(fieldData: fieldDataEncrypted);
  }

  Future<Either<Failure, void>> addFieldLogic(
      {required FieldDataEntity fieldData});

  Future<Either<Failure, void>> updateField(FieldDataEntity fieldData);

  Future<Either<Failure, void>> deleteField(
      {required FieldDataEntity fieldData});

  Future<Either<Failure, List<FieldDataEntity>?>> getFieldsOfAccount(
      {required AccountDataEntity accountData});

  //! Import/Export
  Future<Either<Failure, String>> exportEncryptedDatabase(
      {required String secretKey});

  Future<Either<Failure, void>> importEncryptedDatabase(
      {required String secretKey, required String filepath});
}

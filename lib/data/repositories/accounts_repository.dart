import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../core/errors/failures.dart';

import '../models/account_data_entity.dart';
import '../models/field_data_entity.dart';

abstract class AccountsRepository {
  Future<Either<Failure, void>> addAccount(
      {required AccountDataEntity accountData});

  Future<Either<Failure, void>> updateAccount(AccountDataEntity accountData);

  Future<Either<Failure, void>> deleteAccount(
      {required AccountDataEntity accountData});

  Future<Either<Failure, List<AccountDataEntity>>> getAllAccounts();

  Future<Either<Failure, AccountDataEntity?>> getAccountById(String uuid);

  Future<Either<Failure, void>> addField({required FieldDataEntity fieldData});

  Future<Either<Failure, void>> updateField(FieldDataEntity fieldData);

  Future<Either<Failure, void>> deleteField(
      {required FieldDataEntity fieldData});

  Future<Either<Failure, List<FieldDataEntity>?>> getFieldsOfAccount(
      {required AccountDataEntity accountData});

  Future<Either<Failure, String>> exportEncryptedDatabase(
      {required String secretKey});

  Future<Either<Failure, void>> importEncryptedDatabase(
      {required String secretKey, required String filepath});
}

import 'package:get_it/get_it.dart';
import 'package:my_simple_password_storage_clean/data/data_providers/base_data_provider.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository_impl.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/add_account_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/all_accounts/delete_account_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/export_data_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/preferences_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/add_field_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/single_account_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data_providers/SQLprovider.dart';
import 'logic/cubit/app_key_cubit.dart';
import 'logic/cubit/import_data_cubit.dart';
import 'logic/cubit/single_account/delete_field_cubit.dart';
import 'logic/cubit/single_account/edit_single_account_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! AppRouter
  sl.registerLazySingleton(() => AppRouter(sqlProvider: sl()));

  //! Bloc/Cubit
  //* Singletons
  sl.registerLazySingleton(() => AccountsCubit(accountsRepository: sl()));
  sl.registerLazySingleton(
      () => AddAccountCubit(accountsRepository: sl(), accountsCubit: sl()));
  sl.registerLazySingleton(
      () => DeleteAccountCubit(accountsRepository: sl(), accountsCubit: sl()));

  sl.registerLazySingleton(() => ExportDataCubit(accountsRepository: sl()));
  sl.registerLazySingleton(
    () => ImportDataCubit(
      accountsRepository: sl(),
      accountsCubit: sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppKeyCubit(prefs: sharedPreferences));

  //* Factories
  sl.registerFactoryParam<SingleAccountCubit, AccountDataEntity, void>(
    (accountDataEntity, _) => SingleAccountCubit(
      accountDataEntity: accountDataEntity,
      accountsRepository: sl(),
    ),
  );

  sl.registerFactoryParam<AddFieldCubit, SingleAccountCubit, void>(
    (singleAccountCubit, _) => AddFieldCubit(
      accountsRepository: sl(),
      singleAccountCubit: singleAccountCubit!,
    ),
  );

  sl.registerFactoryParam<DeleteFieldCubit, SingleAccountCubit, void>(
    (singleAccountCubit, _) => DeleteFieldCubit(
      accountsRepository: sl(),
      singleAccountCubit: singleAccountCubit!,
    ),
  );

  sl.registerFactoryParam<EditSingleAccountCubit, SingleAccountCubit, void>(
    (singleAccountCubit, _) => EditSingleAccountCubit(
      accountsRepository: sl(),
      singleAccountCubit: singleAccountCubit!,
    ),
  );

  //! Repository
  sl.registerLazySingleton<AccountsRepository>(
      () => AccountsRepositoryImlp(sqlProvider: sl()));

  //! Data source
  await SQLprovider.db.initDB();
  sl.registerLazySingleton<BaseDataProvider>(() => SQLprovider());
}

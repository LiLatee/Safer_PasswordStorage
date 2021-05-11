import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data_providers/SQLprovider.dart';
import 'data/data_providers/base_data_provider.dart';
import 'data/models/account_data_entity.dart';
import 'data/repositories/accounts_repository.dart';
import 'data/repositories/accounts_repository_impl.dart';
import 'logic/cubit/all_accounts/accounts_cubit.dart';
import 'logic/cubit/all_accounts/add_account_cubit.dart';
import 'logic/cubit/all_accounts/delete_account_cubit.dart';
import 'logic/cubit/general/app_key_cubit.dart';
import 'logic/cubit/general/auth_cubit.dart';
import 'logic/cubit/general/export_data_cubit.dart';
import 'logic/cubit/general/import_data_cubit.dart';
import 'logic/cubit/general/launching_cubit.dart';
import 'logic/cubit/general/phone_lock_cubit.dart';
import 'logic/cubit/general/login_cubit.dart';
import 'logic/cubit/general/theme_cubit.dart';
import 'logic/cubit/single_account/add_field_cubit.dart';
import 'logic/cubit/single_account/delete_field_cubit.dart';
import 'logic/cubit/single_account/edit_single_account_cubit.dart';
import 'logic/cubit/single_account/single_account_cubit.dart';
import 'presentation/router/app_router.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final localAuth = LocalAuthentication();

  //! AppRouter
  sl.registerLazySingleton(() => AppRouter(sqlProvider: sl()));

  //! Bloc/Cubit
  //* Singletons
  sl.registerLazySingleton(() => ThemeCubit(prefs: sharedPreferences));
  sl.registerLazySingleton(() => LoginCubit(prefs: sharedPreferences));
  sl.registerLazySingleton(() => PhoneLockCubit(localAuth: localAuth));
  sl.registerLazySingleton(() => LaunchingCubit(phoneLockCubit: sl()));
  sl.registerLazySingleton(() => AuthCubit(prefs: sharedPreferences));
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
  await SQLprovider().initDB();
  sl.registerLazySingleton<BaseDataProvider>(() => SQLprovider());
}

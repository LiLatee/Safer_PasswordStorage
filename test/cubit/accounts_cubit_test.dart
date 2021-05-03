import 'package:my_simple_password_storage_clean/data/data_providers/SQLprovider.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/repositories/accounts_repository_impl.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  group("AccountsCubit", () {
    late AccountsCubit accountsCubit;

    setUp(() async {
      await SQLprovider.db.initDB();
      AccountsRepositoryImlp accountsRepository =
          AccountsRepositoryImlp(sqlProvider: SQLprovider());
      accountsCubit = AccountsCubit(accountsRepository: accountsRepository);
    });

    tearDown(() {
      accountsCubit.close();
    });

    var testAddAcc = AccountDataEntity(accountName: "Acc1");
    blocTest<AccountsCubit, AccountsState>('Adding account "Acc1"',
        build: () => accountsCubit,
        act: (cubit) => cubit.addAccount(accountData: testAddAcc),
        expect: () => [
              AccountsLoaded(accountDataList: [testAddAcc])
            ]);
  });
}

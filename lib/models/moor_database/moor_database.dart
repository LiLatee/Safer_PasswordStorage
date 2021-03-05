// import 'package:moor/moor.dart';
// import 'package:moor_flutter/moor_flutter.dart';
//
// part 'moor_database.g.dart';
//
// @DataClassName("Accounts")
// class Accounts extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   TextColumn get accountName => text()();
//
//   // Widget icon;
//   BoolColumn get isShowButtonPressed =>
//       boolean().withDefault(Constant(false))();
//
//   BoolColumn get isEditButtonPressed =>
//       boolean().withDefault(Constant(false))();
//
//   @override
//   Set<Column> get primaryKey => {id};
// }
//
// @UseMoor(tables: [Accounts])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase()
//       // Specify the location of the database file
//       : super((FlutterQueryExecutor.inDatabaseFolder(
//           path: 'db.sqlite',
//           // Good for debugging - prints SQL in the console
//           logStatements: true,
//         )));
//
//   // Bump this when changing tables and columns.
//   // Migrations will be covered in the next part.
//   @override
//   int get schemaVersion => 1;
//
//   Future<List<Account>> getAllAccounts() => select(accounts).get();
//   Streams<List<Account>> watchAllAccounts() => select(accounts).watch();
//   Future insertAccount(Acoount account) => into(accounts).insert(account);
//   Future updateAccount(Acoount account) => update(accounts).replace(account)
//   Future deleteAccount(Acoount account) => delete(accounts).delete(account);
// }

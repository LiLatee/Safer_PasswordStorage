// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AccountDao? _accountDaoInstance;

  FieldDataDao? _fieldDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AccountDataEntity` (`uuid` TEXT, `accountName` TEXT NOT NULL, `iconImage` BLOB, `iconColorHex` TEXT, PRIMARY KEY (`uuid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FieldDataEntity` (`uuid` TEXT, `accountId` TEXT NOT NULL, `name` TEXT NOT NULL, `value` TEXT NOT NULL, `isHidden` INTEGER NOT NULL, `isMultiline` INTEGER NOT NULL, `position` INTEGER NOT NULL, FOREIGN KEY (`accountId`) REFERENCES `AccountDataEntity` (`uuid`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`uuid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AccountDao get accountDao {
    return _accountDaoInstance ??= _$AccountDao(database, changeListener);
  }

  @override
  FieldDataDao get fieldDao {
    return _fieldDaoInstance ??= _$FieldDataDao(database, changeListener);
  }
}

class _$AccountDao extends AccountDao {
  _$AccountDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _accountDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'AccountDataEntity',
            (AccountDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountName': item.accountName,
                  'iconImage': item.iconImage,
                  'iconColorHex': item.iconColorHex
                },
            changeListener),
        _accountDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'AccountDataEntity',
            ['uuid'],
            (AccountDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountName': item.accountName,
                  'iconImage': item.iconImage,
                  'iconColorHex': item.iconColorHex
                },
            changeListener),
        _accountDataEntityDeletionAdapter = DeletionAdapter(
            database,
            'AccountDataEntity',
            ['uuid'],
            (AccountDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountName': item.accountName,
                  'iconImage': item.iconImage,
                  'iconColorHex': item.iconColorHex
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AccountDataEntity> _accountDataEntityInsertionAdapter;

  final UpdateAdapter<AccountDataEntity> _accountDataEntityUpdateAdapter;

  final DeletionAdapter<AccountDataEntity> _accountDataEntityDeletionAdapter;

  @override
  Stream<List<AccountDataEntity>> watchAllAccountsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM AccountDataEntity',
        mapper: (Map<String, Object?> row) => AccountDataEntity(
            uuid: row['uuid'] as String?,
            accountName: row['accountName'] as String,
            iconImage: row['iconImage'] as Uint8List?,
            iconColorHex: row['iconColorHex'] as String?),
        queryableName: 'AccountDataEntity',
        isView: false);
  }

  @override
  Future<List<AccountDataEntity>> getAllAccounts() async {
    return _queryAdapter.queryList('SELECT * FROM AccountDataEntity',
        mapper: (Map<String, Object?> row) => AccountDataEntity(
            uuid: row['uuid'] as String?,
            accountName: row['accountName'] as String,
            iconImage: row['iconImage'] as Uint8List?,
            iconColorHex: row['iconColorHex'] as String?));
  }

  @override
  Future<AccountDataEntity?> getAccountById(String uuid) async {
    return _queryAdapter.query(
        'SELECT * FROM AccountDataEntity WHERE uuid = ?1',
        mapper: (Map<String, Object?> row) => AccountDataEntity(
            uuid: row['uuid'] as String?,
            accountName: row['accountName'] as String,
            iconImage: row['iconImage'] as Uint8List?,
            iconColorHex: row['iconColorHex'] as String?),
        arguments: [uuid]);
  }

  @override
  Stream<AccountDataEntity?> watchAccountById(String uuid) {
    return _queryAdapter.queryStream(
        'SELECT * FROM AccountDataEntity WHERE uuid = ?1',
        mapper: (Map<String, Object?> row) => AccountDataEntity(
            uuid: row['uuid'] as String?,
            accountName: row['accountName'] as String,
            iconImage: row['iconImage'] as Uint8List?,
            iconColorHex: row['iconColorHex'] as String?),
        arguments: [uuid],
        queryableName: 'AccountDataEntity',
        isView: false);
  }

  @override
  Future<void> insertAccount(AccountDataEntity account) async {
    await _accountDataEntityInsertionAdapter.insert(
        account, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateAccount(AccountDataEntity account) async {
    await _accountDataEntityUpdateAdapter.update(
        account, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAccount(AccountDataEntity account) async {
    await _accountDataEntityDeletionAdapter.delete(account);
  }
}

class _$FieldDataDao extends FieldDataDao {
  _$FieldDataDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _fieldDataEntityInsertionAdapter = InsertionAdapter(
            database,
            'FieldDataEntity',
            (FieldDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountId': item.accountId,
                  'name': item.name,
                  'value': item.value,
                  'isHidden': item.isHidden ? 1 : 0,
                  'isMultiline': item.isMultiline ? 1 : 0,
                  'position': item.position
                },
            changeListener),
        _fieldDataEntityUpdateAdapter = UpdateAdapter(
            database,
            'FieldDataEntity',
            ['uuid'],
            (FieldDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountId': item.accountId,
                  'name': item.name,
                  'value': item.value,
                  'isHidden': item.isHidden ? 1 : 0,
                  'isMultiline': item.isMultiline ? 1 : 0,
                  'position': item.position
                },
            changeListener),
        _fieldDataEntityDeletionAdapter = DeletionAdapter(
            database,
            'FieldDataEntity',
            ['uuid'],
            (FieldDataEntity item) => <String, Object?>{
                  'uuid': item.uuid,
                  'accountId': item.accountId,
                  'name': item.name,
                  'value': item.value,
                  'isHidden': item.isHidden ? 1 : 0,
                  'isMultiline': item.isMultiline ? 1 : 0,
                  'position': item.position
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FieldDataEntity> _fieldDataEntityInsertionAdapter;

  final UpdateAdapter<FieldDataEntity> _fieldDataEntityUpdateAdapter;

  final DeletionAdapter<FieldDataEntity> _fieldDataEntityDeletionAdapter;

  @override
  Stream<List<FieldDataEntity>?> watchFieldsOfAccount(String accountId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM FieldDataEntity WHERE accountId = ?1',
        mapper: (Map<String, Object?> row) => FieldDataEntity(
            uuid: row['uuid'] as String?,
            accountId: row['accountId'] as String,
            name: row['name'] as String,
            value: row['value'] as String,
            isHidden: (row['isHidden'] as int) != 0,
            isMultiline: (row['isMultiline'] as int) != 0,
            position: row['position'] as int),
        arguments: [accountId],
        queryableName: 'FieldDataEntity',
        isView: false);
  }

  @override
  Future<List<FieldDataEntity>?> getFieldsOfAccount(String accountId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM FieldDataEntity WHERE accountId = ?1',
        mapper: (Map<String, Object?> row) => FieldDataEntity(
            uuid: row['uuid'] as String?,
            accountId: row['accountId'] as String,
            name: row['name'] as String,
            value: row['value'] as String,
            isHidden: (row['isHidden'] as int) != 0,
            isMultiline: (row['isMultiline'] as int) != 0,
            position: row['position'] as int),
        arguments: [accountId]);
  }

  @override
  Future<void> insertField(FieldDataEntity field) async {
    await _fieldDataEntityInsertionAdapter.insert(
        field, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateField(FieldDataEntity field) async {
    await _fieldDataEntityUpdateAdapter.update(field, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteField(FieldDataEntity field) async {
    await _fieldDataEntityDeletionAdapter.delete(field);
  }
}

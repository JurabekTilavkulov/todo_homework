// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_databaseFirst.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  ToDoDao? _toDoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `ToDoModal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `textAny` TEXT NOT NULL, `status` TEXT NOT NULL, `dataTime` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoDao get toDoDao {
    return _toDoDaoInstance ??= _$ToDoDao(database, changeListener);
  }
}

class _$ToDoDao extends ToDoDao {
  _$ToDoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _toDoModalInsertionAdapter = InsertionAdapter(
            database,
            'ToDoModal',
            (ToDoModal item) => <String, Object?>{
                  'id': item.id,
                  'textAny': item.textAny,
                  'status': item.status,
                  'dataTime': item.dataTime
                },
            changeListener),
        _toDoModalUpdateAdapter = UpdateAdapter(
            database,
            'ToDoModal',
            ['id'],
            (ToDoModal item) => <String, Object?>{
                  'id': item.id,
                  'textAny': item.textAny,
                  'status': item.status,
                  'dataTime': item.dataTime
                },
            changeListener),
        _toDoModalDeletionAdapter = DeletionAdapter(
            database,
            'ToDoModal',
            ['id'],
            (ToDoModal item) => <String, Object?>{
                  'id': item.id,
                  'textAny': item.textAny,
                  'status': item.status,
                  'dataTime': item.dataTime
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDoModal> _toDoModalInsertionAdapter;

  final UpdateAdapter<ToDoModal> _toDoModalUpdateAdapter;

  final DeletionAdapter<ToDoModal> _toDoModalDeletionAdapter;

  @override
  Future<List<ToDoModal>> selectedInfor() async {
    return _queryAdapter.queryList('SELECT * FROM ToDoModal',
        mapper: (Map<String, Object?> row) => ToDoModal(
            row['textAny'] as String,
            row['status'] as String,
            row['dataTime'] as String,
            id: row['id'] as int?));
  }

  @override
  Stream<List<ToDoModal>> selectedInforByStream() {
    return _queryAdapter.queryListStream('SELECT * FROM ToDoModal',
        mapper: (Map<String, Object?> row) => ToDoModal(
            row['textAny'] as String,
            row['status'] as String,
            row['dataTime'] as String,
            id: row['id'] as int?),
        queryableName: 'ToDoModal',
        isView: false);
  }

  @override
  Future<void> insertInfor(ToDoModal toDoModal) async {
    await _toDoModalInsertionAdapter.insert(
        toDoModal, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateInfor(ToDoModal toDoModal) async {
    await _toDoModalUpdateAdapter.update(toDoModal, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteInfor(ToDoModal toDoModal) async {
    await _toDoModalDeletionAdapter.delete(toDoModal);
  }
}

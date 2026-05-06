import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  static Database? db;

  Future<Database?> get init async {
    db ??= await initDb();
    return db;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'moneybee.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        isExpense INTEGER NOT NULL,
        date TEXT NOT NULL,
        notes TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE wishlists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    print("Create Tables");
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS wishlists (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');
    }
    print("Upgrade");
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    final db = await init;
    return await db!.rawQuery(sql);
  }

  Future<int> insertData(String sql) async {
    final db = await init;
    return await db!.rawInsert(sql);
  }

  Future<int> updateData(String sql) async {
    final db = await init;
    return await db!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    final db = await init;
    return await db!.rawDelete(sql);
  }
}
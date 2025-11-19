import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/user_model.dart';

class DatabaseService {
  static const String dbName = 'katadia.db';
  static const String usersTable = 'users';
  static const int dbVersion = 1;

  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $usersTable (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        cefrLevel TEXT DEFAULT 'A1',
        xp INTEGER DEFAULT 0,
        streak INTEGER DEFAULT 0,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Migration logic here if needed
  }

  // User operations
  Future<UserModel> insertUser(UserModel user) async {
    try {
      final db = await database;
      final userMap = user.toJson();
      userMap['createdAt'] = DateTime.now().toIso8601String();

      await db.insert(
        usersTable,
        userMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return user;
    } catch (e) {
      throw Exception('Error inserting user: $e');
    }
  }

  Future<UserModel?> getUser(String email) async {
    try {
      final db = await database;
      final maps = await db.query(
        usersTable,
        where: 'email = ?',
        whereArgs: [email],
      );

      if (maps.isEmpty) {
        return null;
      }

      return UserModel.fromJson(maps.first);
    } catch (e) {
      throw Exception('Error getting user: $e');
    }
  }

  Future<UserModel?> getUserById(String id) async {
    try {
      final db = await database;
      final maps = await db.query(
        usersTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        return null;
      }

      return UserModel.fromJson(maps.first);
    } catch (e) {
      throw Exception('Error getting user by id: $e');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      final db = await database;
      await db.update(
        usersTable,
        user.toJson(),
        where: 'id = ?',
        whereArgs: [user.id],
      );

      return user;
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final db = await database;
      await db.delete(
        usersTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<void> deleteAllUsers() async {
    try {
      final db = await database;
      await db.delete(usersTable);
    } catch (e) {
      throw Exception('Error deleting all users: $e');
    }
  }

  Future<void> closeDatabase() async {
    _database?.close();
    _database = null;
  }
}

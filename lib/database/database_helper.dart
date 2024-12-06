import 'package:call_me_app/models/contact.dart';
import 'package:call_me_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'call_me_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT,
            phoneNumber TEXT,
            picture TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE contacts(
            userId TEXT,
            name TEXT,
            phoneNumber TEXT,
            picture TEXT,
            FOREIGN KEY (userId) REFERENCES users (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE calls(
            id TEXT PRIMARY KEY,
            contact TEXT,
            callTime TEXT,
            FOREIGN KEY (contact) REFERENCES contacts (userId)
          )
        ''');
      },
    );
  }

  Future<void> registerUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    const storage = FlutterSecureStorage();
    await storage.write(key: 'userId', value: user.id);
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> userMaps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (userMaps.isNotEmpty) {
      return User.fromMap(userMaps.first);
    }
    return null;
  }

  Future<User?> getCurrentUser() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? userId = await storage.read(key: 'userId');

    if (userId != null) {
      final db = await database;
      final List<Map<String, dynamic>> userMaps = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
      );

      if (userMaps.isNotEmpty) {
        return User.fromMap(userMaps.first);
      }
    }
    return null;
  }

  Future<void> editCurrentUser({required User user}) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> addContact(Contact contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editContact(Contact contact, String phoneNumber) async {
    final db = await database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  Future<void> deleteContact(String phoneNumber) async {
    final db = await database;
    await db.delete(
      'contacts',
      where: 'phoneNumber = ?',
      whereArgs: [phoneNumber],
    );
  }

  Future<List<Contact>> getContacts(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> contactMaps = await db.query(
      'contacts',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(contactMaps.length, (i) {
      return Contact.fromMap(contactMaps[i]);
    });
  }
}

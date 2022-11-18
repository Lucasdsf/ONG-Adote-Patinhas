import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbEstab {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'estabelecimento.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE estabelecimento (cod_estab TEXT PRIMARY KEY, nome_estab TEXT, servicos TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbEstab.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbEstab.database();
    return db.query(table);
  }
}

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class SQLHelper {
  static Future<sql.Database> fetchBookmarksDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'bookmarked_news.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE bookmarked_news(id TEXT PRIMARY KEY, title TEXT, link TEXT, keywords TEXT, creator TEXT, video_url TEXT, description TEXT, content TEXT, pub_date TEXT, full_description TEXT, image_url TEXT, source_id TEXT, show_image BIT)');
    }, version: 1);
  }

  static Future<void> insertBookmark(
      String table, Map<String, Object> dataMap) async {
    final sqlDB = await SQLHelper.fetchBookmarksDB();
    sqlDB.insert(table, dataMap,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> removeBookmark(String table, String bookmarkId) async {
    final sqlDB = await SQLHelper.fetchBookmarksDB();
    sqlDB.delete(table, where: 'id = ?', whereArgs: [bookmarkId]);
  }

  static Future<List<Map<String, dynamic>>> getBookmarks(String table) async {
    final sqlDB = await SQLHelper.fetchBookmarksDB();
    return sqlDB.query(table);
  }
}

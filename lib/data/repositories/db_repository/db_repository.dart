import 'package:english_news_app/model/db_model/favourite_new_model.dart';
import 'package:english_news_app/services/database_services/database_services.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository{

  static Future<int> bookmarkNews(FavouriteNewsModel favouriteNews) async {
    final db = await DatabaseServices.getDb();
    return await db.insert(DatabaseServices.tableName, favouriteNews.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> removeBookmarkNews(FavouriteNewsModel favouriteNews) async {
    final db = await DatabaseServices.getDb();
    return await db.delete(DatabaseServices.tableName, where: 'id=?', whereArgs: [favouriteNews.id]);
  }

  static Future<List<FavouriteNewsModel>> getAllBookmarkNews() async {
    final db = await DatabaseServices.getDb();
    final List<Map<String, dynamic>> maps = await db.query(DatabaseServices.tableName);
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (index) => FavouriteNewsModel.fromJson(maps[index]));
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static const int version = 1;
  static const String databaseName = 'favouriteNews.db';
  static const String tableName = 'FavouriteNewsTable';
  static const String column1 = 'id';
  static const String column2 = 'newsTitle';
  static const String column3 = 'newsPicture';
  static const String column4 = 'newsPublishedAt';
  static const String column5 = 'newsSourceName';
  static const String column6 = 'newsDetails';
  static const String column7 = 'newsUrl';

  static Future<Database> getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) async {
        return await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            $column1 INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $column2 TEXT,
            $column3 TEXT,
            $column4 TEXT,
            $column5 TEXT,
            $column6 TEXT,
            $column7 TEXT
          )
        ''');
      },
      version: version,
    );
  }
}

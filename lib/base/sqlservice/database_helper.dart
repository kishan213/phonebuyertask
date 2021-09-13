import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phonebuyertask/utils/const/sql_const.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, DATABASE_NAME);
    print(path);
    return await openDatabase(path,
        version: DATABASE_VERSION, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $DATABASE_TABLE_NAME (
            $PRODUCT_ID TEXT,
            $PRODUCT_NAME TEXT,
            $PRODUCT_RATING NUMBER,
            $PRODUCT_PRICE NUMBER,
            $PRODUCT_IMAGE TEXT,
            $PRODUCT_DESCRIPTION TEXT,
            $PRODUCT_BRANDG TEXT

           )

          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var db = await instance.database;
    return await db!.insert(DATABASE_TABLE_NAME, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var db = await instance.database;
    return await db!.query(DATABASE_TABLE_NAME);
  }

  //temp query for fatching rows by contact name
  Future<List<Map<String, dynamic>>> queryMobileData(String id) async {
    var db = await instance.database;
    return await db!
        .query(DATABASE_TABLE_NAME, where: '$PRODUCT_ID = ?', whereArgs: [id]);
  }

  Future<int?> queryRowCount() async {
    var db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $DATABASE_TABLE_NAME'));
  }

  Future<int> delete() async {
    var db = await instance.database;
    return await db!.delete(DATABASE_TABLE_NAME, where: null, whereArgs: null);
    //await db.rawDelete('DELETE FROM $DATABASE_TABLE_NAME');
  }

  Future<int> deleteRow(String id) async {
    var db = await instance.database;
    return await db!
        .delete(DATABASE_TABLE_NAME, where: '$PRODUCT_ID = ?', whereArgs: [id]);
  }
}

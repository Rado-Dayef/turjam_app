import 'package:translate_app/constants/app_imports.dart';

class AppDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  /// To initialize the data base.
  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, AppStrings.databaseNameDB);
    Database myDb = await openDatabase(path, onCreate: onCreate, version: 1);
    return myDb;
  }

  /// To create the table in data base at the first time.
  onCreate(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE "languages" (
          "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
          "label" TEXT NOT NULL,
          "value" TEXT NOT NULL
        );
      ''',
    );
  }

  /// To insert languages into the table language.
  Future<void> insertLanguageMenu(List<CoolDropdownItem<String>> languageMenu, GetStartedController controller) async {
    Database? myDb = await db;
    for (var item in languageMenu) {
      await myDb!.insert(
        AppStrings.languagesTableDB,
        {
          AppStrings.labelFieldDB: await controller.translate(item.label),
          AppStrings.valueFieldDB: item.value,
        },
      );
    }
  }

  /// To read the data from database.
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  /// To drop the data base.
  myDeleteDataBase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, AppStrings.databaseNameDB);
    await deleteDatabase(path);
  }
}

import 'dart:io';

import 'package:medicine_hub/models/medicineModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;

  final String _tasksTableName = "Medicine";
  final String _tasksStatusColumnName = "status";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }
Future<Database> createDatabase() async{
  final databaseDirPath = await getDatabasesPath();
  final databasePath = join(databaseDirPath, "medicinehub.db");
  final databased = await openDatabase( databasePath, version: 1,
    onCreate: (db, version) async{
      await db.execute('''CREATE TABLE Medicine(id INTEGER PRIMARY KEY,
      brand TEXT,
      dosageFormId INTEGER,
      dosageFormName TEXT,
      genericId INTEGER,
      genericName TEXT,
      strength TEXT,manufacturedById INTEGER,
      manufacturedByName TEXT,unitPrice REAL,
      packSize TEXT,stripPrice REAL,otherFormBrandId INTEGER ,medicineType TEXT
      ,remarks TEXT,createdOn TEXT,updatedOn TEXT
      )''');
    },
  );
  return databased;
}
void addData(MedicineModel medicineModel) async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "medicinehub.db");
    if(await File(databasePath).exists()){
      print("Existsss");
      Database db = await openDatabase('medicinehub.db');
      insertData(db,medicineModel);
    }else{
      Database db = await createDatabase();
      await insertData(db,medicineModel);
    }

}
Future<void> insertData(Database database,MedicineModel medicineModel) async{
  await database.transaction((txn) async{
    int id1 = await txn.rawInsert('''
      INSERT INTO Medicine(id,brand,dosageFormId,dosageFormName,genericId,
      genericName,strength,manufacturedById,manufacturedByName,unitPrice,
      packSize,stripPrice,otherFormBrandId,medicineType,remarks,createdOn,updatedOn) VALUES(${medicineModel.id},
       "${medicineModel.brand}", ${medicineModel.dosageFormId},
        "${medicineModel.dosageFormName}", ${medicineModel.genericId},
        "${medicineModel.genericName}", "${medicineModel.strength}",
         ${medicineModel.manufacturedById},
      "${medicineModel.manufacturedByName}",
       ${medicineModel.unitPrice},
       "${medicineModel.packSize}", ${medicineModel.stripPrice}, ${medicineModel.otherFormBrandId},
        "${medicineModel.medicineType}","${medicineModel.remarks}","${medicineModel.createdOn}", 
        "${medicineModel.updatedOn}")''',

    );
    print('inserted1: $id1');
  });
}
 Future<List<MedicineModel>> getData()async{
   Database db = await openDatabase('medicinehub.db');
  List<Map> list = await db.rawQuery('SELECT * FROM Medicine');
   List<MedicineModel> finalList = [];
   for (Map i in list) {
     finalList.add(MedicineModel.fromJson(i));
   }
  print(MedicineModel.fromJson(list[1]).medicineType);
  print("get data called");
  return finalList;
}




  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "medicinehub.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('CREATE TABLE Medicine(id INTEGER PRIMARY KEY,brand TEXT,dosageFormId INTEGER,dosageFormName TEXT,genericId INTEGER,genericName TEXT,strength TEXT,manufacturedById INTEGER,manufacturedByName TEXT,unitPrice REAL,packSize TEXT,stripPrice REAL,otherFormBrandId INTEGER ,medicineType TEXT)');
      },
    );
    return database;
  }

  void addTask(
    int id,
    String brand,
    int dosageFormId,
    String dosageFormName,
    int genericId,
    String genericName,
    String strength,
    int manufacturedById,
    String manufacturedByName,
    num unitPrice,
    String packSize,
    num stripPrice,
    int otherFormBrandId,
    String medicineType,
  ) async {
    final db = await database;
    await db.insert(_tasksTableName, {
      "id": id,
      "brand": brand,
      "dosageFormId": dosageFormId,
      "dosageFormName": dosageFormName,
      "genericId": genericId,
      "genericName": genericName,
      "strength": strength,
      "manufacturedById": manufacturedById,
      "manufacturedByName": manufacturedByName,
      "unitPrice": unitPrice,
      "packSize": packSize,
      "stripPrice": stripPrice,
      "otherFormBrandId": otherFormBrandId,
      "medicineType": medicineType,
    });
  }

  Future<List<MedicineModel>> getTasks() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    List<MedicineModel> tasks = data
        .map(
          (e) => MedicineModel(
            id: e["id"] as int,
            brand: e['brand'] as String,
            dosageFormId: e['dosageFormId'] as int,
            dosageFormName: e['dosageFormName'] as String,
            genericId: e['genericId'] as int,
            genericName: e['genericName'] as String,
            strength: e['strength'] as String,
            manufacturedById: e['manufacturedById'] as int,
            manufacturedByName: e['manufacturedByName'] as String,
            unitPrice: e['unitPrice'] as num,
            packSize: e['packSize'] as String,
            stripPrice: e['stripPrice'] as num,
            // isOtherForm : e['isOtherForm'] as bool,
            otherFormBrandId: e['otherFormBrandId'] as int,
            medicineType: e['medicineType'] as String,
            // remarks : e['remarks'],
            // createdOn : e['createdOn'],
            // updatedOn : e['updatedOn'],
            // isActive : e['isActive'],
          ),
        )
        .toList();
    return tasks;
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(
      _tasksTableName,
      {
        _tasksStatusColumnName: status,
      },
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  void deleteTask(
    int id,
  ) async {
    final db = await database;
    await db.delete(
      _tasksTableName,
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }
}

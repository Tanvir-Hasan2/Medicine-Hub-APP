import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import '../models/medicineModel.dart';

class DbHelper{
  final String createTableMHub = '''create table $tableMediHub(
      $tblMHubColId INTEGER PRIMARY KEY AUTOINCREMENT,
      $tblMHubColDId INTEGER,
      $tblMHubColBrand TEXT,
      $tblMHubColDosageFormId INTEGER,
      $tblMHubColDosageFromName TEXT,
      $tblMHubColGenericId INTEGER,
      $tblMHubColGenericName TEXT,
      $tblMHubColStrength TEXT,
      $tblMHubColManufacturedById INTEGER,
      $tblMHubColManufatureByName TEXT,
      $tblMHubColUnitPrice REAL,
      $tblMHubColPackSize TEXT,
      $tblMHubColStripPrice REAL,
      $tblMHubColIsOtherForm INTEGER,
      $tblMHubColOtherFormBrandId INTEGER,
      $tblMHubColMedicineType TEXT,
      $tblMHubColRemarks TEXT,
      $tblMHubColCreatedOn TEXT,
      $tblMHubColUpdatedOn TEXT,
      $tblMHubColIsActive INTEGER)''';

  Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbPath = p.join(root,'mhub.db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version){
         db.execute(createTableMHub);
      },

    );
  }

  // Future<int> insert(MedicineModel medicineModel) async{
  //   final db = await _open();
  //   return await db.insert(
  //     tableMediHub,
  //     medicineModel.toJson(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // Future<void> insertAll(List<MedicineModel> medicineList) async{
  //   final db = await _open();
  //   Batch batch = db.batch();
  //   for( var medicine in medicineList){
  //     batch.insert(
  //         tableMediHub,
  //         medicine.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  //   await batch.commit(noResult: true);
  //
  // }
  //
  // Future<List<MedicineModel>> getMedicinesFromDb() async {
  //   final db = await _open();
  //   final List<Map<String, dynamic>> maps = await db.query(tableMediHub);
  //
  //   return List.generate(maps.length, (i) {
  //     return MedicineModel.fromJson(maps[i]);
  //   });
  // }

}
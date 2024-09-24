import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:medicine_hub/db/database_service.dart';
import 'package:medicine_hub/utils/app_string.dart';
import '../models/medicineModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final DbHelper dbHelper = DbHelper();
  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;
  final DatabaseService _databaseService = DatabaseService();
  List<MedicineModel> medicineList = [];
  List<MedicineModel> localMedicineList = [];
  Future<List<MedicineModel>> getMedicineDetails() async {
    final response = await http.get(Uri.parse(AppString.baseUrl));
    var data = jsonDecode(response.body.toString());
    //print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        medicineList.add(MedicineModel.fromJson(i));
      }

      return medicineList;
    } else {
      return medicineList;
    }
  }
  Future<List<MedicineModel>> localData()async{
    localMedicineList = await _databaseService.getData();
    print(localMedicineList);
    return localMedicineList;
  }

  @override
  void initState() {
    // var dbPath = getDatabasesPath().then((v) {
    //   print("db path $v");
    // });
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
          switch (event) {
            case InternetStatus.connected:
              setState(() {
                isConnectedToInternet = true;
              });
              break;
            case InternetStatus.disconnected:
              setState(() {
                isConnectedToInternet = false;
              });
              break;
            default:
              setState(() {
                isConnectedToInternet = false;
              });
              break;
          }
        });
    data();
    // Future.delayed(Duration(seconds: 3));
    super.initState();
  }
  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  int name = 23339;
void data()async{
//   var databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, 'demo-dd.db');
//
// // Delete the database
//   await deleteDatabase(path);
//
// // open the database
//   Database database = await openDatabase(path, version: 1,
//       onCreate: (Database db, int version) async {
//         // When creating the db, create the table
//         await db.execute(
//             '''CREATE TABLE "Test" (
//                 "id" INTEGER PRIMARY KEY,
//                  name TEXT, value INTEGER,
//                  num REAL)''');
//       });
//   // Insert some records in a transaction
//   await database.transaction((txn) async {
//     int id1 = await txn.rawInsert(
//         '''INSERT INTO Test
//         (id,name,
//         value, num)
//              values
//              ($name,"name",
//              1234, 456.789)''');
//     print('inserted1: $id1');
//     int id2 = await txn.rawInsert(
//         'INSERT INTO Test(id,name, value, num) VALUES(?, ?, ?,?)',
//         [4123,'another name', 12345678, 3.1416]);
//     print('inserted2: $id2');
//   });
//
// // Update some record
//   int count = await database.rawUpdate(
//       'UPDATE Test SET name = ?, value = ? WHERE name = ?',
//       ['updated name', '9876', 'some name']);
//   print('updated: $count');
//
// // Get the records
//   List<Map> list = await database.rawQuery('SELECT * FROM test');
//   List<Map> expectedList = [
//     {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
//     {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
//   ];
//   print(list);
//   print(expectedList);
  // await _databaseService.database;
  // _databaseService.addTask(3, "napa", 22, "supo", 33, "exo", "nice", 44,
  //     "Beximco", 12, "2", 32, 44, "medicineType");
//   await deleteDatabase("/data/user/0/com.example.medicine_hub/databases/medicined.db");
      await getMedicineDetails();
   // _databaseService.createDatabase();
   for(var medicine in medicineList){
     _databaseService.addData(medicine);
   }
   _databaseService.getData();
   // print(medicineList[2].createdOn.runtimeType);
// _databaseService.addData(medicineList[2]);
//   final databaseDirPath = await getDatabasesPath();
//   final databasePath = join(databaseDirPath, "medicinehub.db");
//   await deleteDatabase(databasePath);
// _databaseService.getData();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(AppString.appTitle),
        title:Text(
          isConnectedToInternet
              ? "You are connected to the internet."
              : "You are not connected to the internet.",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              // future: getMedicineDetails(),
              future: localData(),
              builder: (_, snapshot) {
                // localMedicineList = snapshot.data!;
                // medicineList = snapshot.data!;
                if (!snapshot.hasData) {print(snapshot.data);
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: localMedicineList.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data![index].strength);
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(localMedicineList[index].id.toString()),
                              Text(localMedicineList[index].brand.toString()),
                              Text(localMedicineList[index]
                                  .dosageFormName
                                  .toString()),
                              Text(localMedicineList[index].genericName.toString()),
                              Text(localMedicineList[index].strength.toString()),
                              Text(localMedicineList[index]
                                  .manufacturedByName
                                  .toString()),
                              Text(localMedicineList[index].medicineType.toString()),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

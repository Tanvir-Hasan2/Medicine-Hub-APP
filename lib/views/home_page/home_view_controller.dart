import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:medicine_hub/db/database_service.dart';
import 'package:medicine_hub/models/medicineModel.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_hub/utils/app_string.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeViewController extends GetxController {
  RxBool isConnectedToInternet = RxBool(false);
  RxBool isLoading = RxBool(false);
  StreamSubscription? _internetConnectionStreamSubscription;
  final DatabaseService _databaseService = DatabaseService();
  Rx<List<MedicineModel>> medicineList = Rx<List<MedicineModel>>([]);
  Rx<List<MedicineModel>> data = Rx<List<MedicineModel>>([]);
  Rx<List<MedicineModel>> searchData = Rx<List<MedicineModel>>([]);
  Rx<List<MedicineModel>> localMedicineList = Rx<List<MedicineModel>>([]);

  @override
  void onInit() async {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) async {
      switch (event) {
        case InternetStatus.connected:
          isLoading.value = true;
          isConnectedToInternet.value = true;
          final databaseDirPath = await getDatabasesPath();
          final databasePath = join(databaseDirPath, "medicinehub.db");
          if (await File(databasePath).exists()) {
            await deleteDatabase(databasePath);
          }
          medicineList.value.clear();
          await getMedicineDetails();
          data = medicineList;
          searchData.value = data.value;
          for (var medicine in medicineList.value) {
            _databaseService.addData(medicine);
          }
          isLoading.value = false;
          break;
        case InternetStatus.disconnected:
          isLoading.value = true;
          isConnectedToInternet.value = false;
          await localData();
          data = localMedicineList;
          searchData.value = data.value;
          isLoading.value = false;
          break;
        default:
          isConnectedToInternet.value = false;
          break;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _internetConnectionStreamSubscription?.cancel();
    super.onClose();
  }

  Future<List<MedicineModel>> getMedicineDetails() async {
    final response = await http.get(Uri.parse(AppString.baseUrl));
    var data = jsonDecode(response.body.toString());
    //print(data);
    if (response.statusCode == 200) {
      for (Map i in data) {
        medicineList.value.add(MedicineModel.fromJson(i));
      }

      return medicineList.value;
    } else {
      return medicineList.value;
    }
  }

  Future<List<MedicineModel>> localData() async {
    localMedicineList.value = await _databaseService.getData();
    return localMedicineList.value;
  }

  void searchMedicine(String query) {
    final filtered = data.value.where((brandName) {
      final lowercaseBrand = brandName.brand!.toLowerCase();
      final searchInput = query.toLowerCase();
      return lowercaseBrand.contains(searchInput);
    }).toList();
    searchData.value = filtered;
  }
}

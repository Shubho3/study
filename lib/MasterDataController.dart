import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'ApiService.dart';
import 'DatabaseService.dart';
import 'InternetService.dart';
import 'MasterData.dart';

class MasterDataController extends GetxController {
  RxList<MasterData> masterData = <MasterData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    if (await InternetService.isInternetAvailable()) {
      masterData.assignAll(await ApiService.fetchMasterData());
      log("-----------------" + masterData.length.toString());
      DatabaseService.saveMasterData(masterData);
    }else{
// No internet connection, fetch data from the local SQLite database
      List<MasterData> localData = await DatabaseService.getMasterData();

      if (localData.isNotEmpty) {
        masterData.assignAll(localData);
      } else {
        // Handle the case when there is no internet and no local data
        // You may show a message, display a placeholder, etc.
      }

    }
  }

  void deleteMasterData(int index) {
    // Delete master data locally and update SQLite DB
    DatabaseService.deleteMasterData(masterData[index].id!);
    masterData.removeAt(index);
  }
  void addMasterData(String name) async {
    // Add master data locally and update SQLite DB
    int newId = await DatabaseService.saveMasterDataSingle(name);
    masterData.add(MasterData(id: newId, name: name));
  }
  void updateMasterData(int id, String newName) async {
    // Update master data locally and update SQLite DB
    await DatabaseService.updateMasterData(id, newName);
    MasterData updatedData = masterData.firstWhere((data) => data.id == id);
    updatedData.name = newName;
    masterData.refresh();

  }
}

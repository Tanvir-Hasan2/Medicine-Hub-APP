import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_hub/views/home_page/home_view_controller.dart';

class HomeView extends StatelessWidget {
  final HomeViewController _controller = Get.put(HomeViewController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
            // title: const Text(AppString.appTitle),
            title: Obx(() => Text(
                  _controller.isConnectedToInternet.value
                      ? "connected to the internet."
                      : "not connected to the internet.",
              style:  TextStyle(fontSize: 15,
                  color: _controller.isConnectedToInternet.value?Colors.green:Colors.red),
                ))),
        body: Obx(
          () => !_controller.isLoading.value ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search by brand name...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    onChanged: (value) {
                      _controller.searchMedicine(value);
                    },
                  ),
                ),
                const SizedBox(height: 16,),
                Expanded(
                  child: ListView.separated(
                      primary: true,
                      itemCount: _controller.searchData.value.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Id: ${_controller.searchData.value[index].id.toString()}'),
                                Text('Brand name: ${_controller.searchData.value[index].brand.toString()}'),
                                Text('Dosage form name: ${_controller.searchData.value[index].dosageFormName.toString()}'),
                                Text('Generic name: ${_controller.searchData.value[index].genericName.toString()}'),
                                Text('Strength: ${_controller.searchData.value[index].strength.toString()}'),
                                Text('Manufactured name: ${_controller.searchData.value[index].manufacturedByName.toString()}'),
                                Text('Medicine type: ${_controller.searchData.value[index].medicineType.toString()}'),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (context,index) {
                        return const SizedBox(height: 8,);
                  },
                      ),
                ),
              ],
            ),
          ): const Center(child: CircularProgressIndicator(),),
        ));
  }
}

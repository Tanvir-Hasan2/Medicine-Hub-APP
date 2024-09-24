import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicine_hub/utils/app_string.dart';
import 'package:medicine_hub/views/home_page/home_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${AppString.appTitle}',
      home: HomeView(),
    );
  }
}

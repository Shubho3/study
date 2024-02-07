import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'AppRoutes.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Practical Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.masterData,
      getPages: Routes.pages,
    );
  }
}

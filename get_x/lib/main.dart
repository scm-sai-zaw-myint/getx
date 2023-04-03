import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/Modules/home/home_page.dart';
import 'package:get_x/routes/app_pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "GetX state management",
      home: const HomePage(),
      getPages: AppPages.pages,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                title: const Text("Customers"),
              ),
              body: Center(
                child: ElevatedButton(
                    onPressed: () async{
                      Get.toNamed(AppRoutes.customerList);
                    },
                    child: const Text("Customers List")),
              ),
            );
  }
}

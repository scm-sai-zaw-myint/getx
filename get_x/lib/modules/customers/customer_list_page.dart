// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/components/delete_customer_dialog.dart';
import 'package:get_x/components/noti_bar.dart';
import 'package:get_x/models/customer.dart';
import 'package:get_x/modules/customers/customer_form.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_x/modules/customers/customer_controller.dart';

class CustomerListPage extends StatelessWidget {
  final CustomerController customerController = Get.put(CustomerController());
  CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text("Customer List"),
        ),
        body: Obx(() {
          if (Get.arguments != null) {
            controller.getCustomerList.add(Get.arguments);
          }
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          int more = controller.isMoreLoading.value ? 1 : 0;
          return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.getCustomerList.length + more,
            itemBuilder: (context, index) {
              if(controller.isMoreLoading.value && index == controller.getCustomerList.length){
                return const Center(child: Padding(padding: EdgeInsets.all(15),child: CircularProgressIndicator(),),);
              }
              Customer customer = controller.getCustomerList[index];
              return Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: (context) async {
                            customerController.setCustomer(customer);
                            Get.to(() => const CustomerForm(isRegis: false));
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 226, 227, 232),
                          foregroundColor:
                              const Color.fromARGB(255, 16, 197, 152),
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) => {
                            showDialog(
                              context: context,
                              builder: (c) =>
                                  DeleteCustomerDialog(customer, (c) async {
                                controller.deleteCustomer(c.id!);
                              }),
                            )
                          },
                          backgroundColor:
                              const Color.fromARGB(255, 162, 9, 24),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: controller.randomColorGenerator(),
                        child: Center(
                            child: Text(
                          customer.name.substring(0, 1).toUpperCase(),
                        )),
                      ),
                      title: Text(customer.name),
                      subtitle: Text(customer.email),
                    )),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Get.toNamed(AppRoutes.createCustomer);
            NotiBar().show("title", "message", "noti");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

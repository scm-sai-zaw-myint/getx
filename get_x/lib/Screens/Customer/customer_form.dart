import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/Screens/Common/common_widget.dart';
import 'package:get_x/Screens/Common/delete_customer_dialog.dart';
import 'package:get_x/Screens/Common//noti_bar.dart';
import 'package:get_x/Services/Customer/customer_controller.dart';
import 'package:get_x/models/customer.dart';

class CustomerForm extends StatefulWidget {
  final bool isRegis;
  const CustomerForm({required this.isRegis, super.key});

  @override
  createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final CustomerRequest _form = CustomerRequest.empty();

  final CustomerController controller = Get.find();

  @override
  void initState() {
    _dobController.text = DateTime.now().toString().split(" ")[0];
    Customer ccustomer = controller.customer.value;
    if (!widget.isRegis) {
      _form.id = ccustomer.id;
      _form.name = ccustomer.name;
      _form.email = ccustomer.email;
      _form.address = ccustomer.address;
      _form.password = ccustomer.password;
      _form.phone = ccustomer.phone;
      _form.dob = ccustomer.dob;
      _dobController.text = ccustomer.dob.toString().split(" ")[0];
    }
    super.initState();
  }

  String _buttonText() {
    return widget.isRegis ? "Register" : "Update";
  }

  Widget _secondaryButton(CustomerController controller) {
    return widget.isRegis
        ? TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"))
        : TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (c) =>
                    DeleteCustomerDialog(controller.customer.value, (c) async {
                  controller.deleteCustomer(controller.customer.value.id!);
                  Get.back();
                }),
              );
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.isRegis ? "Create cutomer" : "Edit customer"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: _form.name,
                    decoration: CommonWidget.commonInput("Name", false),
                    validator: (value) => CommonWidget.isValidName(value),
                    onChanged: (value) => _form.name = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _form.email,
                    decoration: CommonWidget.commonInput("Email", false),
                    validator: (value) => CommonWidget.isValidEmail(value),
                    onChanged: (value) => _form.email = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    initialValue: _form.phone,
                    decoration: CommonWidget.commonInput("Phone", false),
                    validator: (value) => CommonWidget.isValidPhone(value),
                    onChanged: (value) => _form.phone = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _form.password,
                    obscureText: true,
                    decoration: CommonWidget.commonInput("Password", false),
                    validator: (value) => CommonWidget.isValidPassword(value),
                    onChanged: (value) => _form.password = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _form.password,
                    obscureText: true,
                    decoration:
                        CommonWidget.commonInput("Confirm Password", false),
                    validator: (value) => CommonWidget.isValidConfirmPassword(
                        value, _form.password),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: CommonWidget.dobDecoration(
                        context,
                        "Date of Birth",
                        _dobController.text,
                        (datetime) => {
                              setState(() {
                                _dobController.text =
                                    datetime.toString().split(" ")[0];
                                _form.dob = DateTime.parse(_dobController.text);
                              })
                            }),
                    validator: (value) =>
                        CommonWidget.isValidDobNAddress(value, "Dob"),
                    onChanged: (v) {
                      _form.dob = DateTime.parse(_dobController.text);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _form.address,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Address",
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                    validator: (value) =>
                        CommonWidget.isValidDobNAddress(value, "Address"),
                    onChanged: (value) => _form.address = value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _secondaryButton(controller),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.isRegis) {
                              NotiBar().show("Customer", "Creating customer...",
                                  "loading");
                              await controller.createCustomer(_form);
                              if (!mounted) return;
                              Navigator.pop(context);
                            } else {
                              NotiBar().show("Customer", "Updating customer...",
                                  "loading");
                              await Future.delayed(const Duration(seconds: 3));
                              final updated =
                                  await controller.updateCustomer(_form);
                              if (updated) {
                                if (!mounted) return;
                                Navigator.pop(context);
                              }
                            }
                          }
                        },
                        child: Text(_buttonText()),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CustomerRequest extends Customer {
  CustomerRequest.empty() : super.empty();
}

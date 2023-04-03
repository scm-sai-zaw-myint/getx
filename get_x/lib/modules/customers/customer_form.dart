import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/components/delete_customer_dialog.dart';
import 'package:get_x/components/noti_bar.dart';
import 'package:get_x/models/customer.dart';
import 'package:get_x/Modules/customers/customer_controller.dart';

class CustomerForm extends StatefulWidget{
  final bool isRegis;
  const CustomerForm({required this.isRegis,super.key});

  @override
  createState() => _CustomerFormState();

}

class _CustomerFormState extends State<CustomerForm>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final CustomerRequest _form = CustomerRequest.empty();

  final CustomerController controller = Get.find();

  @override
  void initState() {
    _dobController.text = DateTime.now().toString().split(" ")[0];
    Customer ccustomer = controller.customer.value;
      if(!widget.isRegis){
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
    return widget.isRegis ? "Registration" : "Update";
  }

  Widget _secondaryButton(CustomerController controller) {
    return widget.isRegis
        ? TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"))
        : TextButton(
            onPressed: () async{
              showDialog(context: context, builder: (c) => DeleteCustomerDialog(controller.customer.value, (c) async{ 
                controller.deleteCustomer(controller.customer.value.id!);
                Get.back();
              }),);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ));
  }

  Future<DateTime?> _selectDate(DateTime? initialDate)async {
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: initialDate??DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(builder: (controller){
      
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.isRegis ? "Create cutomer":"Edit customer"),
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
                  decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Customer name",
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter customer name!";
                    } else if (value.length < 4) {
                      return "Customer name must contains at least 4 characters!";
                    }
                    return null;
                  },
                  onChanged: (value) => _form.name = value,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _form.email,
                  decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Customer email",
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter customer email";
                    } 
                    // else if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    //     .hasMatch(value)) {
                    //   return "Invalid email address!";
                    // }
                    return null;
                  },
                  onChanged: (value) => _form.email = value,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _form.phone,
                  decoration: const InputDecoration(
                      labelText: "Phone",
                      hintText: "Phone number",
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter phone number!";
                    } 
                    // else if (RegExp(r'^\+[1-9]{1}[0-9]{3,14}$')
                    //     .hasMatch(value)) {
                    //   return "Invalid phone number!";
                    // }
                    return null;
                  },
                  onChanged: (value) => _form.phone = value,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password!";
                    } else if (value.length < 6) {
                      return "Password must contain at least 6 characters!";
                    }
                    return null;
                  },
                  onChanged: (value) => _form.password = value,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  initialValue: _form.password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm password",
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter confirm password!";
                    } else if (value.length < 6) {
                      return "Password must contain at least 6 characters!";
                    }else if(value != _form.password){
                      return "Password do mot match!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _dobController,
                  decoration:  InputDecoration(
                      labelText: "Date of birth",
                      hintText: "Date of birth",
                      contentPadding: const EdgeInsets.all(5),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      suffixIcon: IconButton(onPressed: () async{
                        DateTime? date = await _selectDate(DateTime.parse(_dobController.text));
                          if (date != null) {
                            setState(() {
                              _dobController.text = date.toString().split(" ")[0];
                              _form.dob = DateTime.parse(_dobController.text);
                            });
                          }
                      }, icon: const Icon(Icons.calendar_month_outlined)),
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter date of birth!";
                    }
                    return null;
                  },
                  onChanged: (v){
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
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter address!";
                    }
                    return null;
                  },
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
                    const SizedBox(width: 15,),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()) {
                          if(widget.isRegis){
                            NotiBar().show("Customer", "Creating customer...", "loading");
                            await controller.createCustomer(_form);
                          }else{
                            NotiBar().show("Customer", "Updating customer...", "loading");
                            await Future.delayed(const Duration(seconds: 3));
                            final updated = await controller.updateCustomer(_form);
                            if(updated){
                              if(!mounted) return;
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
     }
    );
  }

}
class CustomerRequest extends Customer {
  CustomerRequest.empty() : super.empty();
}

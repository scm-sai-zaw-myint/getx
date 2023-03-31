// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_x/models/customer.dart';
typedef OnDeleteCustomer = Function(Customer customer);
class DeleteCustomerDialog extends StatelessWidget {
  final Customer customer;
  final OnDeleteCustomer _onDeleteCustomer;
  const DeleteCustomerDialog(this.customer, this._onDeleteCustomer, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Customer"),
      content: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(text: "${customer.name}\n", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const TextSpan(text: "Are your sure to delete this customer?", style: TextStyle(fontSize: 14))
        ]
      )),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel")),
        ElevatedButton(
            onPressed: (){
                _onDeleteCustomer(customer);
              Navigator.pop(context);
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red),),
            child: const Text("Delete"))
      ],
      
    );
  }
}

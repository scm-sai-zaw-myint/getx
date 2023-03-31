import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x/Services/customer_api.dart';
import 'package:get_x/models/customer.dart';

class CustomerController extends GetxController{
  var isLoading = true.obs;
  var isMoreLoading = false.obs;
  var page = 1.obs;

  final customer = Customer.empty().obs;
  final _customerList = <Customer>[].obs;
  CustomerAPI customerApi = CustomerAPI();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    fetchCustomerList();
    scrollController.addListener(() {
      if(isMoreLoading.value) return;
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels){
        loadMore(page.value);
      }
    });
    super.onInit();
  }

  void setCustomer(Customer c) => customer.value = c;
  
  Future<bool> createCustomer(Customer c) async{
    Customer? cc = await customerApi.createCustomer(c);
    if(cc == null) return false;
    _customerList.insert(0, cc);
    return true;
  }
  Future<bool> updateCustomer(Customer c) async{
    Customer? cc = await customerApi.updateCustomer(c);
    if(cc == null) return false;
    int index = _customerList.indexWhere((c) => c.id == cc.id);
    if(index != -1){
      _customerList[index] = cc;
    }
    return true;
  }

  Future<void> deleteCustomer(int id) async{
    bool delete = await customerApi.deleteCustomer(id);
    if(!delete) return;
    int index = _customerList.indexWhere((c) => c.id == id);
    if(index != -1){
      _customerList.remove(_customerList[index]);
    }
  }

  List<Customer> get getCustomerList => _customerList.value;

  addCustomer(Customer customer) => _customerList.insert(0, customer);
  Color randomColorGenerator() => Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
      
  fetchCustomerList() async {
    isLoading(true);
    _customerList.value = (await customerApi.getCustomer(1));
    isLoading(false);
  }
  loadMore(int offset) async{
    isMoreLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    _customerList.addAll(await customerApi.getCustomer(offset+1));
    page(offset+1);
    isMoreLoading(false);
  }
}
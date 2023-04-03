import 'package:get/get.dart';
import 'package:get_x/Modules/customers/customer_controller.dart';

class CustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerController());
  }
  
}
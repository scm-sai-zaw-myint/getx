import 'package:get/get.dart';
import 'package:get_x/modules/customers/customer_controller.dart';

class CustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerController());
  }
  
}
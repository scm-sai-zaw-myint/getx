import 'package:get/get.dart';
import 'package:get_x/Services/Customer/customer_controller.dart';

class CustomerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerController());
  }
}

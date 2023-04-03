import 'package:get/get.dart';
import 'package:get_x/Modules/customers/customer_binding.dart';
import 'package:get_x/Screens/Customer/customer_form.dart';
import 'package:get_x/Modules/home/home_page.dart';
import 'package:get_x/Screens/Customer/customer_list_page.dart';
import 'package:get_x/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        ),
    GetPage(
      name: AppRoutes.customerList,
      page: () => CustomerListPage(),
      binding: CustomerBinding(),
    ),
    GetPage(
        name: AppRoutes.createCustomer,
        page: () => const CustomerForm(
              isRegis: true,
            ),
    ),
    GetPage(
        name: AppRoutes.editCustomer,
        page: () => const CustomerForm(
              isRegis: false,
            ),
    ),
  ];
}

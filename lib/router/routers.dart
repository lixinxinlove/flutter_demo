import 'package:get/get.dart';

import '../middleware/address_middleware.dart';
import '../pages/KeyboardVisibilityChangesPage.dart';
import '../pages/address_page.dart';
import '../pages/login_page.dart';
import '../pages/root_page.dart';

class Routers {
  static final routers = [
    GetPage(name: "/", page: () => const RootPage()),
    GetPage(name: "/login", page: () => const LoginPage()),
    GetPage(name: "/address", page: () => const AddressPage(), middlewares: [
      AddressMiddleware(),
    ]),
    GetPage(
        name: "/keyboard", page: () => const KeyboardVisibilityChangesPage()),
  ];
}

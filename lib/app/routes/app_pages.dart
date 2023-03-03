import 'package:chat_demo_firebase/app/user/view/user_screen.dart';
import 'package:get/get.dart';
import '../home/binding/home_binding.dart';
import '../home/view/home_screen.dart';
import '../user/binding/user_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    ///home screen
    GetPage(
      name: Routes.routeHome,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),

    ///user screen
    GetPage(
      name: Routes.routeUser,
      page: () => const UserScreen(),
      binding: UserBinding(),
    ),
  ];
}

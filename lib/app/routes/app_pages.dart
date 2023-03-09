import 'package:chat_demo_firebase/app/chat/view/chat_screen.dart';
import 'package:chat_demo_firebase/app/login/view/login_screen.dart';
import 'package:get/get.dart';
import '../chat/binding/chat_binding.dart';
import '../login/binding/login_binding.dart';
import '../users/binding/users_binding.dart';
import '../users/view/users_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    ///home screen
    GetPage(
      name: Routes.routeLogin,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    ///user screen
    GetPage(
      name: Routes.routeUsers,
      page: () => const UsersScreen(),
      binding: UsersBinding(),
    ),

    ///chat screen
    GetPage(
      name: Routes.routeChat,
      page: () => const ChatScreen(),
      binding: ChatBinding(),
    ),
  ];
}

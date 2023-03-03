import 'package:chat_demo_firebase/app_utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_routes.dart';

class UserController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final currentUser = firebaseAuth.currentUser;

  logoutGoogle() {
    return Get.defaultDialog(
      middleText: AppStrings.logOutMsg,
      textCancel: AppStrings.cancelStr,
      onCancel: () => Get.back(),
      textConfirm: AppStrings.confirmStr,
      onConfirm: () {
        googleSignIn.signOut();
        Get.offAllNamed(Routes.routeHome);
      },
    );
  }
}

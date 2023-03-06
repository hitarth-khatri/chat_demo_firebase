import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_routes.dart';

class UsersController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final currentUser = firebaseAuth.currentUser;

  ///log out dialog
  logoutGoogle() {
    return Get.defaultDialog(
      middleText: AppStrings.logOutMsg,
      textCancel: AppStrings.cancelStr,
      onCancel: () => Get.back(),
      textConfirm: AppStrings.confirmStr,
      onConfirm: () {
        googleSignIn.signOut();
        Get.offAllNamed(Routes.routeLogin);
      },
    );
  }
}

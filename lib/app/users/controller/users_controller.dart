import 'package:chat_demo_firebase/common/constants/app_strings.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_routes.dart';

class UsersController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late final currentUser = FirebaseAuth.instance.currentUser;

  final chatRoomId = "".obs;

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

  ///get room id
  getChatRoomId({required String receiverId}) {
    if (currentUser!.uid.hashCode <= receiverId.hashCode) {
      chatRoomId.value = '${currentUser!.uid}-$receiverId';
    } else {
      chatRoomId.value = '$receiverId-${currentUser!.uid}';
    }
  }
}

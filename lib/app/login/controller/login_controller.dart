import 'package:chat_demo_firebase/app/login/model/user_model.dart';
import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late final User? currentUser;

  ///login with google
  loginWithGoogle() async {
    try {
      EasyLoading.show();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      await firebaseAuth.signInWithCredential(credential);

      currentUser = firebaseAuth.currentUser;
      printDebug(value: "uid: ${currentUser?.uid}");

      //add user to realtime db
      if (currentUser != null && await isNewUser(currentUser!.uid)) {
        final user = UserModel(
          uid: currentUser?.uid ?? "",
          name: currentUser?.displayName ?? "",
          email: currentUser?.email ?? "",
          profileUrl: currentUser?.photoURL ?? "",
        );

        await FirebaseConstants.usersDatabaseReference
            .push()
            .set(user.toJson());

        printDebug(value: "${currentUser?.email} added");
      } else {
        printDebug(value: "${currentUser?.email} already exist");
      }

      //navigate to user screen
      Get.offNamed(Routes.routeUsers);

      EasyLoading.dismiss();
      Get.rawSnackbar(
        title: AppStrings.success,
        message: AppStrings.loggedInSuccess,
      );

      return;
    } catch (e) {
      EasyLoading.dismiss();
      printDebug(value: e);
    }
  }

  ///new user
  Future<bool> isNewUser(String uid) async {
    DatabaseEvent result = await FirebaseConstants.usersDatabaseReference
        .orderByChild("uid")
        .equalTo(uid)
        .once();

    return result.snapshot.children.isEmpty;
  }
}

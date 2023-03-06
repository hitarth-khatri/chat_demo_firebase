import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:chat_demo_firebase/common/enum/loading_status.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    printDebug(value: firebaseAuth.currentUser?.email);
    super.onInit();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late final User? currentUser;

  final loginStatus = LoadStatus.initial.obs;

  ///login with google
  loginWithGoogle() async {
    try {
      loginStatus.value = LoadStatus.loading;

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

      //add user to firestore
      if (currentUser != null && await isNewUser(currentUser!.uid)) {
        await FirebaseConstants.usersCollection.add({
          'uid': currentUser?.uid,
          'name': currentUser?.displayName,
          'email': currentUser?.email,
          'photo': currentUser?.photoURL,
        });

        printDebug(value: "${currentUser?.email} added");
      } else {
        printDebug(value: "${currentUser?.email} already exist");
      }

      //navigate to user screen
      Get.offNamed(Routes.routeUser);
      loginStatus.value = LoadStatus.success;
      Get.rawSnackbar(
        title: AppStrings.success,
        message: AppStrings.loggedInSuccess,
      );

      return;
    } catch (e) {
      loginStatus.value = LoadStatus.failure;
      printDebug(value: e);
    }
  }

  ///new user
  Future<bool> isNewUser(String uid) async {
    final QuerySnapshot result = await FirebaseConstants.usersCollection
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    printDebug(value: "result: ${result.size}");
    return result.size == 0;
  }
}

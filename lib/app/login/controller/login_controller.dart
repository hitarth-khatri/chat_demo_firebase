import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:chat_demo_firebase/common/enum/loading_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    if (kDebugMode) {
      print(firebaseAuth.currentUser?.email);
    }
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

      print("uid: ${currentUser?.uid}");
      if (currentUser != null && await isNewUser(currentUser!.uid)) {
        await FirebaseConstants.usersCollection.add({
          'uid': currentUser?.uid,
          'name': currentUser?.displayName,
          'email': currentUser?.email,
          'photo': currentUser?.photoURL,
        });
        if (kDebugMode) {
          print("${currentUser?.email} added");
        }
      } else {
        if (kDebugMode) {
          print("${currentUser?.email} already exist");
        }
      }

      Get.offNamed(Routes.routeUser);
      loginStatus.value = LoadStatus.success;
      Get.rawSnackbar(
        title: AppStrings.success,
        message: AppStrings.loggedInSuccess,
      );
      return;
    } catch (e) {
      loginStatus.value = LoadStatus.failure;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  ///new user
  Future<bool> isNewUser(String uid) async {
    final QuerySnapshot result = await FirebaseConstants.usersCollection
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    print("result: ${result.size}");
    return result.size == 0;
  }
}

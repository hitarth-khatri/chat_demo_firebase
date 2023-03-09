import 'dart:async';
import 'package:chat_demo_firebase/common/constants/app_colors.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    googleSignIn.isSignedIn().then(
          (value) => printDebug(value: "logged in: $value"),
        );

    Timer(const Duration(seconds: 2), () async {
      await googleSignIn.isSignedIn()
          ? Get.offNamed(
              Routes.routeUsers,
            )
          : Get.offNamed(
              Routes.routeLogin,
            );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.indigo100,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

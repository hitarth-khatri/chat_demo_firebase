import 'package:chat_demo_firebase/app/login/controller/login_controller.dart';
import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/enum/loading_status.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => controller.loginStatus.value == LoadStatus.loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.loginWithGoogle(),
                        child: const Text(AppStrings.logInStr),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

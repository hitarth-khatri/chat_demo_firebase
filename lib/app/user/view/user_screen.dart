import 'package:chat_demo_firebase/app/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_utils/app_strings.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Page"),
          actions: [
            TextButton(
              onPressed: () => controller.logoutGoogle(),
              child: const Text(AppStrings.logOutStr),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(AppStrings.loggedInStr),
              Text("email: ${controller.currentUser!.email}"),
              Image.network(controller.currentUser!.photoURL!).paddingAll(20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/app_strings.dart';

///debug print
printDebug({required value}) {
  if (kDebugMode) {
    print(value);
  }
}

///remove focus
removeFocus() => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();


///exit dialog
exitDialog() {
  Get.dialog(
    barrierDismissible: false,
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text(AppStrings.yesStr),
            ),
            TextButton(
              onPressed: () => Get.back(canPop: false),
              child: const Text(AppStrings.noStr),
            ),
          ],
          title: const Text(AppStrings.exitMsg),
        ),
      ),
    ),
  );
}

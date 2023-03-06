import 'package:chat_demo_firebase/app/routes/app_routes.dart';
import 'package:chat_demo_firebase/common/constants/app_icons.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget usersListTile(
    {required String profileImage,
    required String email,
    required String name}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(profileImage),
      radius: 20,
    ),
    title: Text(email),
    subtitle: Text(name),
    trailing: IconButton(
      onPressed: () {
        printDebug(value: "Chat screen");
        Get.toNamed(Routes.routeChat);
      },
      icon: AppIcons.messageIcon,
    ),
  );
}

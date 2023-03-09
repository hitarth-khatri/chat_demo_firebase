import 'package:chat_demo_firebase/app/users/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_icons.dart';
import '../../../common/constants/app_strings.dart';
import '../../../common/widgets/common_widgets.dart';
import '../../routes/app_routes.dart';

///Users drawer
Widget usersDrawer() {
  final controller = Get.find<UsersController>();
  return Drawer(
    child: ListView(
      primary: false,
      children: [
        DrawerHeader(
          //user details
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    NetworkImage(controller.currentUser!.photoURL!),
                radius: 25,
              ).paddingSymmetric(horizontal: 15),
              Text(
                controller.currentUser?.displayName ?? "",
              ),
            ],
          ),
        ),
        //log out
        ListTile(
          title: const Text(AppStrings.logOutStr),
          leading: AppIcons.logoutIcon,
          onTap: () => controller.logoutGoogle(),
        ),
      ],
    ),
  );
}

//users tile
Widget userListTile({
  required senderId,
  required String senderEmail,
  required String senderName,
  required String senderProfile,
  required receiverId,
  required String receiverEmail,
  required String receiverName,
  required String receiverProfile,
  String recentMsg = "",
}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(receiverProfile),
      radius: 25,
    ),
    onTap: () {
      printDebug(value: "Chat screen");
      Get.toNamed(
        Routes.routeChat,
        arguments: {
          "senderId": senderId,
          "senderEmail": senderEmail,
          "senderName": senderName,
          "senderProfile": senderProfile,
          "receiverId": receiverId,
          "receiverEmail": receiverEmail,
          "receiverName": receiverName,
          "receiverProfile": receiverProfile,
        },
      );
    },
    title: Text(receiverEmail),
    subtitle: Text(recentMsg),
    trailing: AppIcons.messageIcon,
  );
}


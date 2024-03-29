import 'package:chat_demo_firebase/app/routes/app_routes.dart';
import 'package:chat_demo_firebase/common/constants/app_icons.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget usersListTile({
  required senderId,
  required String senderEmail,
  required String senderName,
  required String senderProfile,
  required receiverId,
  required String receiverEmail,
  required String receiverName,
  required String receiverProfile,
  String recentMsg = "Recent Msg",
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

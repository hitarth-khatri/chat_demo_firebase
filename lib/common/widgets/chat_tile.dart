import 'package:chat_demo_firebase/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

messageTile({
  required AlignmentGeometry? alignment,
  required double width,
  required String message,
  required String messageType,
}) {
  return messageType == "message"
      ? Container(
          alignment: alignment,
          width: width / 1.6,
          color: AppColors.orange50,
          child: ListTile(title: Text(message)),
        ).paddingAll(5)
      : Image.network(
          message,
          fit: BoxFit.cover,
          width: width / 1.6,
          height: 190,
        ).paddingAll(5);
}

import 'package:chat_demo_firebase/common/constants/app_colors.dart';
import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.orange50,
          ),
          child: ListTile(title: Text(message)),
        ).paddingAll(5)
      : InkWell(
          onTap: () => Get.dialog(
            AlertDialog(
              content: CachedNetworkImage(
                imageUrl: message,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.contain),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(AppStrings.close),
                ),
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: message,
            width: width / 1.6,
            height: 220,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).paddingAll(5),
        );
}

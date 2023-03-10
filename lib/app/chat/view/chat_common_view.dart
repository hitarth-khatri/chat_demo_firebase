import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_demo_firebase/app/chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/constants/app_strings.dart';
import '../controller/chat_controller.dart';

//message column
Widget messageColumn({
  CrossAxisAlignment messageAlignment = CrossAxisAlignment.end,
  required double width,
  required MessageModel messageModel,
}) {
  return Column(
    crossAxisAlignment: messageAlignment,
    children: [
      messageTile(
        alignment: Alignment.centerRight,
        width: width,
        messageType: messageModel.messageType,
        message: messageModel.message,
      ),
    ],
  );
}

//send text field
Widget sendTextField() {
  final controller = Get.find<ChatController>();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    color: AppColors.white,
    child: TextFormField(
      controller: controller.msgController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "Enter message",
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            //send image
            IconButton(
              onPressed: () => controller.requestGallery(),
              icon: AppIcons.uploadImage,
            ),
            //send text
            IconButton(
              onPressed: () => controller.sendMessage(),
              icon: AppIcons.sendIcon,
            ),
          ],
        ),
      ),
    ),
  );
}

//message tile
messageTile({
  required AlignmentGeometry? alignment,
  required double width,
  required String message,
  required String messageType,
}) {
  return messageType == AppStrings.messageTypeMessage
      ? Container(
          alignment: alignment,
          width: width / 1.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.orange50,
          ),
          child: ListTile(
            title: Text(message),
          ),
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

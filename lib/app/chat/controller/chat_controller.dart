import 'dart:io';

import 'package:chat_demo_firebase/app/chat/model/message_model.dart';
import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/widgets/common_widgets.dart';

class ChatController extends GetxController {
  late TextEditingController msgController;

  String chatRoomId = "";

  late Query chatDbQuery;

  var senderId = Get.arguments["senderId"] ?? "";
  String senderEmail = Get.arguments["senderEmail"] ?? "";
  String senderName = Get.arguments["senderName"] ?? "";
  String senderProfile = Get.arguments["senderProfile"] ?? "";

  var receiverId = Get.arguments["receiverId"] ?? "";
  String receiverEmail = Get.arguments["receiverEmail"] ?? "";
  String receiverName = Get.arguments["receiverName"] ?? "";
  String receiverProfile = Get.arguments["receiverProfile"] ?? "";

  XFile? galleryImage;
  var imgPath = "".obs;
  Rx<File> imageFile = File("").obs;

  @override
  void onInit() {
    msgController = TextEditingController();
    getChatRoomId();
    chatDbQuery = FirebaseConstants.chatDatabaseReference.child(chatRoomId);
    super.onInit();
  }

  @override
  void onClose() {
    msgController.dispose();
    super.onClose();
  }

  ///send message
  sendMessage() {
    removeFocus();
    if (msgController.text.trim().isNotEmpty) {
      final message = MessageModel(
        senderId: senderId,
        senderEmail: senderEmail,
        senderName: senderName,
        senderProfile: senderProfile,
        receiverId: receiverId,
        receiverEmail: receiverEmail,
        receiverName: receiverName,
        receiverProfile: receiverProfile,
        message: msgController.text,
        sentTime: DateTime.now(),
      );

      FirebaseConstants.chatDatabaseReference
          .child(chatRoomId)
          .push()
          .set(message.toJson());
      printDebug(value: "sent message");
      msgController.clear();
    } else {
      Get.snackbar(
        AppStrings.invalid,
        AppStrings.invalidMsg,
        duration: const Duration(milliseconds: 800),
      );
      printDebug(value: "empty message");
    }
  }

  ///send image
  uploadImage() {
    requestGallery();
  }

  ///get chat room id
  getChatRoomId() {
    if (senderId.hashCode <= receiverId.hashCode) {
      chatRoomId = '$senderId-$receiverId';
    } else {
      chatRoomId = '$receiverId-$senderId';
    }
  }

  ///get image from gallery
  requestGallery() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      printDebug(value: "Permission Granted");
      galleryImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (galleryImage != null) {
        imgPath.value = galleryImage!.path;
        printDebug(value: "Image path: $imgPath");
        imageFile.value = File(imgPath.value);
        msgController.text = "Image selected";
        return imageFile.value;
      }
    } else if (status.isPermanentlyDenied) {
      printDebug(value: "Permission Denied");
      Get.defaultDialog(
        middleText: "Permission denied",
        confirm: TextButton(
          onPressed: () => openAppSettings(),
          child: const Text("open setting"),
        ),
      );
    }
  }
}

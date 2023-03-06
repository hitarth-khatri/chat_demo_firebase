import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_widgets.dart';

class ChatController extends GetxController {
  late TextEditingController msgController;

  late Query dbQuery;
  String chatRoomId = "";

  var senderId = Get.arguments["senderId"] ?? "";
  String senderEmail = Get.arguments["senderEmail"] ?? "";
  String senderName = Get.arguments["senderName"] ?? "";
  String senderProfile = Get.arguments["senderProfile"] ?? "";

  var receiverId = Get.arguments["receiverId"] ?? "";
  String receiverEmail = Get.arguments["receiverEmail"] ?? "";
  String receiverName = Get.arguments["receiverName"] ?? "";
  String receiverProfile = Get.arguments["receiverProfile"] ?? "";

  @override
  void onInit() {
    msgController = TextEditingController();
    getChatRoomId();
    dbQuery = FirebaseConstants.databaseReference.child(chatRoomId);
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
      Map<String, dynamic> message = {
        "senderId": senderId,
        "senderEmail": senderEmail,
        "senderName": senderName,
        "senderProfile": senderProfile,
        "receiverId": receiverId,
        "receiverEmail": receiverEmail,
        "receiverName": receiverName,
        "receiverProfile": receiverProfile,
        "message": msgController.text,
        "sentTime": "${DateTime.now()}",
      };
      FirebaseConstants.databaseReference.child(chatRoomId).push().set(message);
      printDebug(value: "sent message");
      msgController.clear();
    } else {
      Get.snackbar(
        "Invalid",
        "Field can't be empty",
        duration: const Duration(milliseconds: 800),
      );
      printDebug(value: "empty message");
    }
  }

  ///get chat room id
  getChatRoomId() {
    if (senderId.hashCode <= receiverId.hashCode) {
      chatRoomId = '$senderId-$receiverId';
    } else {
      chatRoomId = '$receiverId-$senderId';
    }
  }
}

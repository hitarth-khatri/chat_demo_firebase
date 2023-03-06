import 'package:chat_demo_firebase/app/chat/controller/chat_controller.dart';
import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.chatPage),
        ),
        body: Column(
          children: [
            Center(
              child: Text(controller.test),
            )
          ],
        ),
      ),
    );
  }
}

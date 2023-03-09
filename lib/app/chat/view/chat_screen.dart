import 'package:chat_demo_firebase/app/chat/controller/chat_controller.dart';
import 'package:chat_demo_firebase/app/chat/model/message_model.dart';
import 'package:chat_demo_firebase/common/constants/app_colors.dart';
import 'package:chat_demo_firebase/common/constants/app_icons.dart';
import 'package:chat_demo_firebase/common/widgets/chat_tile.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(controller.receiverProfile),
              ).paddingOnly(right: 5),
              Text(controller.receiverName),
            ],
          ),
        ),
        body: FirebaseAnimatedList(
          primary: false,
          reverse: true,
          padding: const EdgeInsets.all(5),
          defaultChild: const Center(child: CircularProgressIndicator()),
          query: controller.chatDbQuery,
          itemBuilder: (context, snapshot, animation, index) {
            final json = snapshot.value as Map;
            final messageModel = MessageModel.fromJson(json);
            return controller.senderId == messageModel.senderId
                ?
                //sender column right
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      messageModel.messageType == "message"
                          ? messageTile(
                              alignment: Alignment.centerRight,
                              width: width,
                              message: messageModel.message,
                            )
                          : const Text("Image"),
                      /*controller.galleryImage != null
                          ? Image.file(
                              controller.imageFile.value,
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            )
                          : Container(),*/
                    ],
                  )
                :
                //receiver column left
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      messageModel.messageType == "message"
                          ? messageTile(
                              alignment: Alignment.centerLeft,
                              width: width,
                              message: messageModel.message,
                            )
                          : const Text("Image"),
                    ],
                  );
          },
        ).paddingOnly(bottom: 80),

        //send message text field
        bottomSheet: Container(
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
                  IconButton(
                    onPressed: () {
                      controller.uploadImage();
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: AppIcons.sendIcon,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

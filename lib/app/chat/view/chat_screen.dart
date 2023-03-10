import 'package:chat_demo_firebase/app/chat/controller/chat_controller.dart';
import 'package:chat_demo_firebase/app/chat/model/message_model.dart';
import 'package:chat_demo_firebase/app/chat/view/chat_common_view.dart';
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
        body: ListView(
          shrinkWrap: true,
          primary: false,
          reverse: true,
          children: [
            FirebaseAnimatedList(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(5),
              defaultChild: const Center(child: CircularProgressIndicator()),
              query: controller.chatDbQuery,
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map;
                final messageModel = MessageModel.fromJson(json);
                return controller.senderId == messageModel.senderId
                    ?
                    //sender column right
                    messageColumn(
                        width: width,
                        messageModel: messageModel,
                      )
                    :
                    //receiver column left
                    messageColumn(
                        messageAlignment: CrossAxisAlignment.start,
                        width: width,
                        messageModel: messageModel,
                      );
              },
            ),
          ],
        ).paddingOnly(bottom: 80),

        //send text field
        bottomSheet: sendTextField(),
      ),
    );
  }
}

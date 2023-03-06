import 'package:chat_demo_firebase/app/chat/controller/chat_controller.dart';
import 'package:chat_demo_firebase/common/widgets/chat_tile.dart';
import 'package:chat_demo_firebase/common/widgets/common_widgets.dart';
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
        resizeToAvoidBottomInset: true,
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
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FirebaseAnimatedList(
              primary: false,
              padding: const EdgeInsets.all(5),
              defaultChild: const Center(child: CircularProgressIndicator()),
              query: controller.dbQuery,
              itemBuilder: (context, snapshot, animation, index) {
                Map messageMap = snapshot.value as Map;
                messageMap['key'] = snapshot.key;
                printDebug(value: "msg: ${messageMap["message"]}");
                return controller.senderId == messageMap["senderId"]
                    ?
                    //sender column right
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          chatTile(
                            alignment: Alignment.centerRight,
                            width: width,
                            message: messageMap["message"],
                          ),
                        ],
                      )
                    :
                    //receiver column left
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatTile(
                            alignment: Alignment.centerLeft,
                            width: width,
                            message: messageMap["message"],
                          ),
                        ],
                      );
              },
            ),
            Container(
              color: Colors.white,
              child: TextFormField(
                controller: controller.msgController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Enter message",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.sendMessage();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 8),
          ],
        ),
      ),
    );
  }
}

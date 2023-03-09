import 'package:chat_demo_firebase/app/login/model/user_model.dart';
import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_icons.dart';
import '../../../common/constants/app_strings.dart';
import '../../../common/widgets/common_widgets.dart';
import '../../../common/widgets/users_tile.dart';
import '../controller/users_controller.dart';

class UsersScreen extends GetView<UsersController> {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          exitDialog();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(AppStrings.userPage),
          ),
          drawer: Drawer(
            child: ListView(
              primary: false,
              children: [
                DrawerHeader(
                  //user details
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.currentUser!.photoURL!),
                        radius: 25,
                      ).paddingSymmetric(horizontal: 15),
                      Text(
                        controller.currentUser?.displayName ?? "",
                      ),
                    ],
                  ),
                ),
                //log out
                ListTile(
                  title: const Text(AppStrings.logOutStr),
                  leading: AppIcons.logoutIcon,
                  onTap: () => controller.logoutGoogle(),
                ),
              ],
            ),
          ),
          //users list
          body: FirebaseAnimatedList(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            defaultChild: const Center(child: CircularProgressIndicator()),
            query: FirebaseConstants.usersDatabaseReference,
            itemBuilder: (context, snapshotUsers, animation, index) {
              final json = snapshotUsers.value as Map;
              final userModel = UserModel.fromJson(json);
              controller.getChatRoomId(receiverId: userModel.uid);
              return StreamBuilder(
                stream: FirebaseConstants.chatDatabaseReference
                    .child(controller.chatRoomId.value)
                    .limitToLast(1)
                    .onValue,
                builder: (context, snapshotChats) {
                  if (snapshotChats.connectionState ==
                      ConnectionState.waiting) {
                    return Container();
                  } else {
                    if (snapshotChats.data!.snapshot.exists) {
                      final jsonMsg = snapshotChats.data!.snapshot.value as Map;
                      var message = jsonMsg.values.map((e) => e["message"]);
                      userModel.lastMessage = message.first;
                      var messageType =
                          jsonMsg.values.map((e) => e["messageType"]);
                      userModel.lastMessageType = messageType.first;
                      printDebug(value: "message: ${message.first}");
                      printDebug(value: "messageType: ${messageType.first}");
                    }

                    return snapshotUsers.children.length <= 1
                        ? const Center(
                            child: Text(AppStrings.noUsers),
                          )
                        : userModel.uid == controller.currentUser?.uid
                            ? Container()
                            : usersListTile(
                                senderId: controller.currentUser!.uid,
                                senderEmail: controller.currentUser!.email!,
                                senderName:
                                    controller.currentUser!.displayName!,
                                senderProfile:
                                    controller.currentUser!.photoURL!,
                                receiverId: userModel.uid,
                                receiverEmail: userModel.email,
                                receiverName: userModel.name,
                                recentMsg: userModel.lastMessageType ==
                                        AppStrings.messageTypeMessage
                                    ? userModel.lastMessage
                                    : AppStrings.messageTypeImage,
                                receiverProfile: userModel.profileUrl,
                              );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

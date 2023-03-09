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
              return StreamBuilder(
                stream: FirebaseConstants.chatDatabaseReference
                    .child(controller.chatRoomId.value)
                    .onValue,
                builder: (context, snapshotChats) {
                  if (snapshotChats.connectionState ==
                      ConnectionState.waiting) {
                    return Container();
                  } else {
                    // printDebug(value: "chat snap: ${snapshotChats.data!.snapshot.value}");
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
                                // recentMsg: controller.lastMessage.value,
                                receiverProfile: userModel.profileUrl,
                              );
                  }
                },
              );

              /*return snapshot.children.length <= 1
                  ? const Center(
                      child: Text(AppStrings.noUsers),
                    )
                  : userModel.uid == controller.currentUser?.uid
                      ? Container()
                      : usersListTile(
                          senderId: controller.currentUser!.uid,
                          senderEmail: controller.currentUser!.email!,
                          senderName: controller.currentUser!.displayName!,
                          senderProfile: controller.currentUser!.photoURL!,
                          receiverId: userModel.uid,
                          receiverEmail: userModel.email,
                          receiverName: userModel.name,
                          // recentMsg: controller.lastMessage.value,
                          receiverProfile: userModel.profileUrl,
                        );*/
            },
          ),
          /*body: StreamBuilder<QuerySnapshot>(
            stream: controller.firebaseConstants!.usersCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return snapshot.data!.docs.length <= 1
                    ? const Center(
                        child: Text(AppStrings.noUsers),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          controller.getChatRoomId(receiverId: document["uid"]);
                          // convertIntoString();
                          return document["uid"] == controller.currentUser?.uid
                              ? Container()
                              : Obx(
                                  () => usersListTile(
                                    senderId: controller.currentUser!.uid,
                                    senderEmail: controller.currentUser!.email!,
                                    senderName:
                                        controller.currentUser!.displayName!,
                                    senderProfile:
                                        controller.currentUser!.photoURL!,
                                    receiverId: document["uid"],
                                    receiverEmail: document["email"],
                                    receiverName: document["name"],
                                    recentMsg: controller.lastMessage.value,
                                    receiverProfile: document["photo"],
                                  ),
                                );
                        },
                      );
              }
            },
          ),*/
        ),
      ),
    );
  }

/*convertIntoString() async {
    controller.lastMessage.value = await controller.getLastMsg() ?? "";
  }*/
}

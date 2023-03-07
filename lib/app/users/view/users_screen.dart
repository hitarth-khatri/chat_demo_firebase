import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart' as real_db;

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
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseConstants.usersCollection.snapshots(),
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
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            if (controller.currentUser!.uid.hashCode <=
                                document["uid"].hashCode) {
                              controller.chatRoomId.value =
                                  '${controller.currentUser!.uid.hashCode}-${document["uid"]}';
                            } else {
                              controller.chatRoomId.value =
                                  '${document["uid"]}-${controller.currentUser!.uid.hashCode}';
                            }

                            real_db.Query dbQuery = FirebaseConstants
                                .databaseReference
                                .child(controller.chatRoomId.value);
                            return document["uid"] ==
                                    controller.currentUser?.uid
                                ? Container()
                                : usersListTile(
                                    senderId: controller.currentUser!.uid,
                                    senderEmail: controller.currentUser!.email!,
                                    senderName:
                                        controller.currentUser!.displayName!,
                                    senderProfile:
                                        controller.currentUser!.photoURL!,
                                    receiverId: document["uid"],
                                    receiverEmail: document["email"],
                                    receiverName: document["name"],
                                    receiverProfile: document["photo"],
                                  );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                }
              },
            )),
      ),
    );
  }
}

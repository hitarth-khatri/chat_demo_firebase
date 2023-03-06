import 'package:chat_demo_firebase/common/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_icons.dart';
import '../../../common/constants/app_strings.dart';
import '../../../common/widgets/users_tile.dart';
import '../controller/users_controller.dart';

class UsersScreen extends GetView<UsersController> {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.currentUser!.photoURL!),
                        radius: 20,
                      ).paddingAll(15),
                      Text(
                        controller.currentUser?.displayName ?? "",
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text(AppStrings.logOutStr),
                  leading: AppIcons.logoutIcon,
                  onTap: () => controller.logoutGoogle(),
                ),
              ],
            ),
          ),
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
                          return document["uid"] == controller.currentUser?.uid
                              ? Container()
                              : usersListTile(
                                  profileImage: document["photo"],
                                  email: document["email"],
                                  name: document["name"],
                                );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              }
            },
          )),
    );
  }
}

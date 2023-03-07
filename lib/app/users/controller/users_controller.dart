import 'package:chat_demo_firebase/common/constants/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as real_db;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../common/constants/firebase_constants.dart';
import '../../../common/widgets/common_widgets.dart';
import '../../routes/app_routes.dart';

class UsersController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late final currentUser = firebaseAuth.currentUser;

  final chatRoomId = "".obs;
  final lastMessage = "".obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseConstants? firebaseConstants;

  @override
  void onInit() {
    super.onInit();
    firebaseConstants = FirebaseConstants(
      firestore: firestore,
      usersCollection: firestore.collection("users"),
      chatDatabaseReference:
          real_db.FirebaseDatabase.instance.ref().child("chat_list"),
    );
  }

  ///log out dialog
  logoutGoogle() {
    return Get.defaultDialog(
      middleText: AppStrings.logOutMsg,
      textCancel: AppStrings.cancelStr,
      onCancel: () => Get.back(),
      textConfirm: AppStrings.confirmStr,
      onConfirm: () {
        googleSignIn.signOut();
        Get.offAllNamed(Routes.routeLogin);
      },
    );
  }

  ///get room id
  getChatRoomId({required String receiverId}) {
    if (currentUser!.uid.hashCode <= receiverId.hashCode) {
      chatRoomId.value = '${currentUser!.uid}-$receiverId';
      // getLastMsg();
    } else {
      chatRoomId.value = '$receiverId-${currentUser!.uid}';
      // getLastMsg();
    }
  }

  ///get last message
  Future<String?> getLastMsg() async {
    printDebug(value: "chat id: ${chatRoomId.value}");
    real_db.Query dbQuery = firebaseConstants!.chatDatabaseReference
        .child(chatRoomId.value)
        .limitToLast(1);
    var event = await dbQuery.once();
    if (event.snapshot.exists) {
      printDebug(value: "snapshot value ${event.snapshot.value.runtimeType}");
      final json = event.snapshot.value as Map;
      var message = json.values.map((message) => message["message"]);
      printDebug(value: "msg: ${message.first}");
      return message.first;
      // return lastMessage.value = message.first;
    } else {
      return null;
    }
  }
}

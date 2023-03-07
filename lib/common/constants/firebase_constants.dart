import 'package:firebase_database/firebase_database.dart';

class FirebaseConstants {
  static DatabaseReference usersDatabaseReference =
      FirebaseDatabase.instance.ref().child("users");
  static DatabaseReference chatDatabaseReference =
      FirebaseDatabase.instance.ref().child("chats");

  /*static Query chatDbQuery = chatDatabaseReference.child(chatRoomId);

  ///get chat room id
  getChatRoomId({required String senderId, required String receiverId}) {
    if (senderId.hashCode <= receiverId.hashCode) {
      chatRoomId = '$senderId-$receiverId';
    } else {
      chatRoomId = '$receiverId-$senderId';
    }
  }*/
}

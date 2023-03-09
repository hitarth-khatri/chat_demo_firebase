import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseConstants {
  static DatabaseReference usersDatabaseReference =
      FirebaseDatabase.instance.ref("users");
  static DatabaseReference chatDatabaseReference =
      FirebaseDatabase.instance.ref("chats");

  static final storageRef = FirebaseStorage.instance.ref("images");
}

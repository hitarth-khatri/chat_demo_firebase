import 'package:firebase_database/firebase_database.dart';

class FirebaseConstants {
  static DatabaseReference usersDatabaseReference =
      FirebaseDatabase.instance.ref("users");
  static DatabaseReference chatDatabaseReference =
      FirebaseDatabase.instance.ref("chats");
}

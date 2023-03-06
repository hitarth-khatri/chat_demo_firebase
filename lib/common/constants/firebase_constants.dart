import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseConstants {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection = firestore.collection('users');

  static DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child("Chat List");
}

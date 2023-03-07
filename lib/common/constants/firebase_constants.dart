import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseConstants {
  FirebaseFirestore firestore;

  // = FirebaseFirestore.instance;
  CollectionReference usersCollection;

  // = firestore.collection('users');

  DatabaseReference chatDatabaseReference;

  // = FirebaseDatabase.instance.ref().child("Chat List");

  FirebaseConstants({
    required this.firestore,
    required this.usersCollection,
    required this.chatDatabaseReference,
  });

  getMessageInstant() {}
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConstants {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference usersCollection = firestore.collection('users');
}

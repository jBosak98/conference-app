import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContinuousUsersRepository {
  FirebaseFirestore _firestore;

  ContinuousUsersRepository(this._firestore);


  Stream<QuerySnapshot> users() =>
     _firestore
        .collection("user")
        .snapshots();

}
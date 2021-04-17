import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContinuousUsersRepository {
  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;
  User _user;

  ContinuousUsersRepository(this._firestore, this._firebaseAuth);

  void loadUser(){
    _user = _firebaseAuth.currentUser;
  }

  Stream<QuerySnapshot> users() =>
     _firestore
        .collection("user")
        .snapshots();

}
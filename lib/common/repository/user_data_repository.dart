import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';

class UserDataRepository {
  FirebaseMessaging _firebaseMessaging;
  FirebaseFirestore _firestore;

  UserDataRepository(this._firestore, this._firebaseMessaging);

  void saveUserData(User user) {
    _firebaseMessaging.getToken().then((token) => _pushUserData(user,token));
  }

  void _pushUserData(User user, String token) {
    _firestore
        .collection("user")
        .doc(user.uid)
        .set({
          'name': user.displayName,
          'pushToken': token,
          'userImg': user.photoURL
        });
  }

  Observable<DocumentSnapshot> getUserData(String uid){
    return Observable.fromFuture(
      _firestore.collection("user")
          .doc(uid)
          .get()
    );
  }
}
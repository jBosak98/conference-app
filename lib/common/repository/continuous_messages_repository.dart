
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContinuousMessagesRepository {
  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;
  User _user;

  ContinuousMessagesRepository(this._firestore, this._firebaseAuth){
    _user = _firebaseAuth.currentUser;
  }

  Stream<QuerySnapshot> chatStream(String roomId){
    return _firestore
        .collection("room")
        .doc(roomId)
        .collection("chat")
        .snapshots();
  }

  String getMyUserId() => _user.uid;

  Stream<QuerySnapshot> sendMessage(String roomId, content) {
    final docReference = _firestore
        .collection("room")
        .doc(roomId)
        .collection("chat")
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    _firestore.runTransaction((transaction)  async {
      transaction.set(docReference, {
        'userId': getMyUserId(),
        'content': content,
        'userName': _user.displayName,
        'imgUrl': _user.photoURL
      });
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:session/common/bloc/base_bloc.dart';
import 'package:session/common/repository/continuous_users_repository.dart';

class ChatLobbyBloc extends BaseBloc {
  ContinuousUsersRepository _continuousUsersRepository;
  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;
  ChatLobbyBloc(
      this._continuousUsersRepository,
      this._firebaseAuth,
      this._firestore);

  Stream<QuerySnapshot> usersStream(){
    return _continuousUsersRepository.users();
  }

  Function isPrivateChatOfTwoUsers(firstUserId,secondUserId) =>
          (QueryDocumentSnapshot room){

    final containsParticipants = room.data().keys.contains('participants');
    if(containsParticipants == false) return false;
    final participants = room.data()['participants'] as List<dynamic>;
    final isPrivate = participants.length == 2;

    return isPrivate
        && participants.contains(firstUserId)
        && participants.contains(secondUserId);
  };

  Future<dynamic> createPrivateRoom(List<String> participants) async {
      return await _firestore.collection("room").add({
        "participants":participants
      });
  }

  Future<String> getPrivateRoomIdWithUser(String userId) async {
    final myId = _firebaseAuth.currentUser.uid;
    final rooms = await _firestore.collection("room").get();
    dynamic room = rooms
        .docs
        .firstWhere(
        isPrivateChatOfTwoUsers(userId,myId),
        orElse: () => null);
    final participants = [userId, myId];
    final roomId = room == null
        ? (await createPrivateRoom(participants)).id
        : room.id;
    return roomId;
  }


}
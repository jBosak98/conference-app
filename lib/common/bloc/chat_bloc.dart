

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session/common/repository/continuous_messages_repository.dart';

import 'base_bloc.dart';

class ChatBloc extends BaseBloc {
  ContinuousMessagesRepository _continuousMessagesRepository;

  ChatBloc(this._continuousMessagesRepository);

  Stream<QuerySnapshot> continuousMessagesStream(roomId) =>
      _continuousMessagesRepository.chatStream(roomId);

  void sendMessage(roomId, content) =>
      _continuousMessagesRepository.sendMessage(roomId, content);

  String getMyUserId() => _continuousMessagesRepository.getMyUserId();
}
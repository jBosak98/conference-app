import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:session/common/bloc/base_bloc.dart';
import 'package:session/common/repository/continuous_users_repository.dart';

class ChatLobbyBloc extends BaseBloc {
  ContinuousUsersRepository _continuousUsersRepository;

  ChatLobbyBloc(this._continuousUsersRepository);

  Stream<QuerySnapshot> usersStream(){
    return _continuousUsersRepository.users();
  }


}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/chat_bloc.dart';
import 'package:session/common/bloc/login_bloc.dart';
import 'package:session/common/repository/continuous_messages_repository.dart';
import 'package:session/common/repository/continuous_users_repository.dart';
import 'package:session/common/repository/user_data_repository.dart';
import 'package:session/ui/app.dart';

import 'common/bloc/calendar_bloc.dart';
import 'common/bloc/chat_lobby_bloc.dart';

void main() async {
  final injector = Injector.appInstance;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;
  final userDataRepository = UserDataRepository(_firestore, _firebaseMessaging);
  final continuousUsersRepository = ContinuousUsersRepository(_firestore);
  final chatLobbyBloc = ChatLobbyBloc(continuousUsersRepository,firebaseAuth, _firestore);
  final calendarBloc = CalendarBloc();

  injector.registerDependency<CalendarBloc>(() => calendarBloc);
  injector.registerDependency<FirebaseAuth>(() => firebaseAuth);
  injector.registerDependency<LoginBloc>(() => LoginBloc(firebaseAuth, userDataRepository));
  injector.registerDependency(() => ContinuousMessagesRepository(_firestore, firebaseAuth));
  injector.registerDependency<ChatBloc>(() => ChatBloc(injector.get<ContinuousMessagesRepository>()));
  injector.registerDependency<ChatLobbyBloc>(() => chatLobbyBloc);
  runApp(App(injector));
}

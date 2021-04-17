import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/chat_bloc.dart';
import 'package:session/common/bloc/chat_lobby_bloc.dart';
import 'package:session/common/bloc/login_bloc.dart';

import 'chat/chat_lobby_page.dart';
import 'chat/chat_page.dart';
import 'login/login_page.dart';
import 'room/room_page.dart';

class App extends StatelessWidget {

  App(this._injector);
  final Injector _injector;

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: 'Flutter samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home: RoomPage( title: 'My room'),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) =>
            LoginPage(_injector.get<LoginBloc>(), title: 'Login/Register'),
        '/chatLobby':(BuildContext context) =>
            ChatLobbyPage(_injector.get<ChatLobbyBloc>(), title: "Chat lobby"),
        '/chat': (BuildContext context) =>
            ChatPage(_injector.get<ChatBloc>(), title: "Chat")
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/calendar_bloc.dart';
import 'package:session/common/bloc/chat_bloc.dart';
import 'package:session/common/bloc/chat_lobby_bloc.dart';
import 'package:session/common/bloc/login_bloc.dart';

import 'chat/chat_lobby_page.dart';
import 'chat/chat_page.dart';
import 'login/login_page.dart';
import 'main/main_page.dart';
import 'room/calendar_page.dart';


class LandingPage extends StatelessWidget {
  final LoginBloc _loginBloc;

  LandingPage(this._loginBloc, {Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    _loginBloc.getCurrentUID().then((uid) {
      if (uid != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class App extends StatelessWidget {

  App(this._injector);

  final Injector _injector;

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    final loginBloc = _injector.get<LoginBloc>();


    return MaterialApp(
      title: 'Flutter samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      home:LandingPage(loginBloc),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => MainPage(_injector),
        '/login': (BuildContext context) =>
            LoginPage(loginBloc, title: 'Login/Register'),
        '/chat': (BuildContext context) =>
            ChatPage(_injector.get<ChatBloc>(), title: "Chat")
      },
    );
  }

}

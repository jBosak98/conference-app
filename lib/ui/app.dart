import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/chat_bloc.dart';
import 'package:session/common/bloc/login_bloc.dart';

import 'chat/chat_page.dart';
import 'landing/landing_page.dart';
import 'login/login_page.dart';
import 'main/main_page.dart';


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

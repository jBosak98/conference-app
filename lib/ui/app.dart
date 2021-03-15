import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/login_bloc.dart';

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
        accentColor: Colors.amberAccent,
      ),
      home: LoginPage(_injector.get<LoginBloc>(), title: 'My room'),
//      routes: <String, WidgetBuilder> {
//        '/login': (BuildContext context) =>
//            LoginPage(title: 'Login/Register'),
//      },
    );
  }
}
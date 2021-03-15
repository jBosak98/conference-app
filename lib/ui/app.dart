import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'room/room_page.dart';

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      title: 'Flutter samples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent,
      ),
      home: RoomPage(title: 'My room', args: "globalRoom"),
//      routes: <String, WidgetBuilder> {
//        '/login': (BuildContext context) =>
//            LoginPage(title: 'Login/Register'),
//      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget{
  final String title;
  final String args;
  RoomPage( {Key key, this.title, this.args}): super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomPageState();

}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.message),
                onPressed: () => Navigator.pushNamed(context, '/chat')
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Navigator.pushNamed(context, '/login')
            ),
          ],
      ),
    );
  }
}

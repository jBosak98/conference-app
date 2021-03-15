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
      ),
    );
  }
}

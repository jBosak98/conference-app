

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:session/ui/chat/chat_page.dart';

class ChatLobbyPage extends StatefulWidget {
  ChatLobbyPage({Key key, this.title}): super(key:key);

  final String title;

  @override
  State<StatefulWidget> createState() => _ChatLobbyState();

}

class _ChatLobbyState extends State<ChatLobbyPage> {

  @override
  Widget build(BuildContext context) {
    final titleWidgets =  <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 8.0),
        child: Icon(Icons.group),
      ),
      Text("Global chat",
        style: TextStyle(fontSize: 18.0),
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.white,
              child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(
                          context,
                          '/chat',
                          arguments: ChatArguments('global')
                          ),
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                          children: titleWidgets
                )
              )),
            )
          ],
        )
    );
  }
}
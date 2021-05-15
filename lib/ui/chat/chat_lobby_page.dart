import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:session/common/bloc/chat_lobby_bloc.dart';
import 'package:session/ui/chat/chat_page.dart';

import '../simple_container.dart';
import '../simple_list_view.dart';

class ChatLobbyPage extends StatefulWidget {
  ChatLobbyPage(this.chatLobbyBloc, {Key key, this.title}) : super(key: key);

  final ChatLobbyBloc chatLobbyBloc;
  final String title;

  @override
  State<StatefulWidget> createState() => _ChatLobbyState();
}

class _ChatLobbyState extends State<ChatLobbyPage> {
  Widget _divider({double height = 1.0, Color color = Colors.white30}) =>
      Divider(
        color: color,
        height: height,
        thickness: 1.0,
      );

  @override
  Widget build(BuildContext context) {
    final globalChat =
        _chatCell(() async => 'global', 'Global chat', Icon(Icons.group));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(widget.title),
        ),
        body: Container(
          decoration:BoxDecoration(
              color: Colors.grey[100],
          ),
            child: Column(
          children: <Widget>[globalChat, _divider(height: 10.0), _usersList()],
        )));
  }

  Widget _chatCell(Function getRoomId, String text, icon) {
    final children = [
      Padding(
        padding: EdgeInsets.only(right: 15.0, top: 6),
        child: Container(width: 40, child: icon),
      ),
      Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
//        textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0, color: Color(0xff363636)),
              ))),
    ];

    return SimpleContainer(
      false,
      children: children,
      margin: EdgeInsets.only(top: 10),
      onPressed: () async {
        final roomId = await getRoomId();
        Navigator.pushNamed(context, '/chat', arguments: ChatArguments(roomId));
      },
    );
  }

  Widget _usersList() {
    return StreamBuilder(
      stream: widget.chatLobbyBloc.usersStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return _listViewBuilder(snapshot.data);
        } else if (snapshot.hasError) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Error has occured"),
          ));
        }
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("No chats"),
        ));
      },
    );
  }

  Widget _listViewBuilder(QuerySnapshot response) {
    return Expanded(
        child: SimpleListView(
            children: [...response.docs.map((doc) => _userChatCell(doc))]));
    //_userChatCell(doc)
  }

  Widget _userChatCell(QueryDocumentSnapshot user) {
    String name = user.data()['name'];
    String avatarUrl = user.data()['userImg'];

    String userUid = user.data()['uid'];
    final getRoomId = () async {
      return widget.chatLobbyBloc.getPrivateRoomIdWithUser(userUid);
    };

    Widget avatar = avatarUrl != null
        ? CircleAvatar(backgroundImage: NetworkImage(avatarUrl))
        : Icon(Icons.accessibility_new);
    return _chatCell(getRoomId, name, avatar);
  }
}

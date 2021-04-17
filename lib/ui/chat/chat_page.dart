import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:session/common/bloc/chat_bloc.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.chatBloc, {Key key, this.title}): super(key:key);

  final ChatBloc chatBloc;
  final String title;

  @override
  State<StatefulWidget> createState() => _ChatPageState();

}
class ChatArguments {
  final String roomId;

  ChatArguments(this.roomId);
}
class _ChatPageState extends State<ChatPage> {
  final TextEditingController textEditingController =
    new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WillPopScope(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[buildListMessages(args.roomId), buildInput(args.roomId)],
              )
            ],
          )
      ),
    );
  }
    Widget buildListMessages(roomId) =>
        Flexible(
          child: Center(
              child: StreamBuilder(
                  stream: widget.chatBloc.continuousMessagesStream(roomId),
                  builder: (context, snapshot) =>
                  snapshot.hasData && snapshot.data.docs.length != 0
                      ? _listViewBuilder(snapshot)
                      : Center(
                      child:Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("This chat is empty!")
                      )
                  )
              )
          ),
        );

    bool _isItMe(messageUserId)
    => messageUserId == widget.chatBloc.getMyUserId();

    Widget _listViewBuilder(AsyncSnapshot<QuerySnapshot> snapshot) =>
        ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) =>
                _buildMessage(index, snapshot.data.docs[index]),
            itemCount: snapshot.data.docs.length
        );

    _buildMessage(int index, QueryDocumentSnapshot document) =>
        Row(
          mainAxisAlignment: _isItMe(document['userId'])
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: _isItMe(document['userId'])
                  ? _myMessage(document)
                  : _otherMessage(document),
              margin: EdgeInsets.only(bottom: 10),
            )
          ],
        );

    Widget _otherMessage(QueryDocumentSnapshot document) =>
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(backgroundImage: NetworkImage(document['imgUrl'])),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  document['content'],
                  textAlign: TextAlign.left,
                )
            )
          ],
        );

    Widget _myMessage(QueryDocumentSnapshot document) =>
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Text(document['content'], textAlign: TextAlign.right)
          ),
          CircleAvatar(backgroundImage: NetworkImage(document['imgUrl']))
        ]);


    Widget buildInput(roomId) =>
        Container(
            color:Colors.blue,
            child: Row(
              children: <Widget>[

                Flexible(
                  child: Container(

                    padding: EdgeInsets.all(13.0),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                ),
                Material(
                  child: new Container(
                    color: Colors.blue,
                    padding: new EdgeInsets.symmetric(horizontal: 8.0),
                    child: new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: () => onSendMessage(textEditingController.text, roomId),
                    ),
                  ),
                  color: Colors.white,
                ),
              ],
            ),
            width: double.infinity,
            height: 50.0
        );

    onSendMessage(String content,roomId) {
      if(content.trim() != '') {
        textEditingController.clear();
        widget.chatBloc.sendMessage(roomId, content);
      }
      else {
        print('Nothing to send');
      }
    }
  }





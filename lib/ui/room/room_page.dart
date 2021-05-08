import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  final String title;
  final String args;

  RoomPage({Key key, this.title, this.args}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoomPageState();
}

class Event {
  final String img;
  final String title;
  final String author;
  final String dateString;

  Event(this.img, this.title, this.author, this.dateString);
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    List<Event> events = [
      Event(
        "images/me.jpg",
        "How to write Flutter app",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/ja.jpg",
        "Docker security",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/ja2.jpg",
        "Clojure - language of the future",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/ja3.jpg",
        "Test Driven Development",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/ja4.jpg",
        "Typescript - hot or not?",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/ja4.jpg",
        "GraphQL - a query language for your API",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/me.jpg",
        "Microservices architecture - introduction",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
      Event(
        "images/me.jpg",
        "How to write Flutter app",
        "Jakub Bosak",
        "May 27, 6:00PM",
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff053F5E),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.message),
                onPressed: () => Navigator.pushNamed(context, '/chatLobby')),
            IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () => Navigator.pushNamed(context, '/login')),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                )),
            child: Column(

              children: [
                Expanded(

                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ListView(children: [
                          ...events
                              .map<Widget>((event) =>
                              eventComponent(event.img,
                                  event.title, event.author, event.dateString))
                              .toList()
                        ])))
              ],
            )));
  }

  Widget eventComponentRightSite(String name, String author,
      String dateString) {
    final size = MediaQuery
        .of(context)
        .size;
    return Flexible(
        child: Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(name,
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(children: [
                      Text(author,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: 3, left: size.width * 0.15),
                          child: Row(children: [
                            Container(
                                child: Text(dateString,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Roboto')))
                          ]))
                    ]))
              ],
            )));
  }

  Widget eventComponent(String img, String name, String author,
      String dateString) {
    return Row(

        children:[Flexible(
        child:Container(
//        height: 90,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                height: 90,
                width: 50,
                child: Image.asset(img)),
            eventComponentRightSite(name, author, dateString)

          ],
        )))]);
  }
}

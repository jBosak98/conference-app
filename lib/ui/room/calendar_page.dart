import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:session/common/bloc/calendar_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalendarPage extends StatefulWidget {
  final String title;
  final String args;
  final CalendarBloc calendarBloc;

  CalendarPage(this.calendarBloc, {Key key, this.title, this.args})
      :super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarPageState();
}

class ConferenceEvent {
  final String id;
  final String img;
  final String title;
  final String author;
  final String dateString;

  ConferenceEvent(this.id, this.img, this.title, this.author, this.dateString);
}

extension CalendarEvent on ConferenceEvent{
  Event toCalendarEvent(String calendarId){
    return Event(
        calendarId,
        title: this.title,
        start: DateTime.now(),
        end:DateTime.now().add(Duration(days: 3))
    );
  }
}

class _CalendarPageState extends State<CalendarPage> {
  List<String> _checkedEvents = [];

  @override
  Widget build(BuildContext context) {
    final events = widget.calendarBloc.getEvents();


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(widget.title),
          actions: <Widget>[
            _checkedEvents.isNotEmpty ? IconButton(
              icon: Icon(Icons.event),
              onPressed:  ()async{
                await widget.calendarBloc.exportEvents(_checkedEvents);
                Fluttertoast.showToast(
                    msg: "Events added to the calendar",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.indigo,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                setState((){
                  _checkedEvents = [];
                });
              }
            ) : Container() ,
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
                              .map<Widget>((event) => GestureDetector(
                                  onLongPress: (){
                                    setState((){
                                      _checkedEvents.contains(event.id)
                                          ? _checkedEvents.remove(event.id)
                                          : _checkedEvents.add(event.id);
                                    });
                                    print('onLongPress$_checkedEvents');
                                  },
                                  child: eventComponent(
                                      event.img,
                                      event.title,
                                      event.author,
                                      event.dateString,
                                      _checkedEvents.contains(event.id)
                                  )
                          ))
                              .toList()
                        ])))
              ],
            )));
  }

  Widget eventComponentRightSite(
      String name, String author, String dateString, bool isChecked) {
    final size = MediaQuery.of(context).size;
    final secondaryTextColor = isChecked ? Color(0xff363636) : Color(0xffababab);
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
                          fontWeight: FontWeight.w700,
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(children: [
                      Text(author,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w300,
                          )),
                      Container(
                          margin:
                              EdgeInsets.only(top: 3, left: size.width * 0.15),
                          child: Row(children: [
                            Container(
                                child: Text(dateString,
                                    style: TextStyle(
                                        color: secondaryTextColor,
                                        fontSize: 12,
                                        fontFamily: 'Roboto')))
                          ]))
                    ]))
              ],
            )));
  }

  Widget eventComponent(
      String img,
      String name,
      String author,
      String dateString,
      bool isChecked
      ) {
    return Row(children: [
      Flexible(
          child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: isChecked? Colors.indigoAccent.withOpacity(0.2) : Colors.white,
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
                  eventComponentRightSite(name, author, dateString, isChecked)
                ],
              )))
    ]);
  }
}

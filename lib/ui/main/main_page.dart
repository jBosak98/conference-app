
import 'package:flutter/cupertino.dart';
import 'package:injector/injector.dart';
import 'package:session/common/bloc/calendar_bloc.dart';
import 'package:session/common/bloc/chat_lobby_bloc.dart';
import 'package:session/ui/chat/chat_lobby_page.dart';
import 'package:session/ui/room/calendar_page.dart';
import 'package:session/ui/shop/shop_page.dart';

class MainPage extends StatefulWidget {
  PageController _controller = PageController(initialPage: 1);

  final Injector _injector;
  MainPage(this._injector, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget._controller,
      children: [
        ShopPage(),
        CalendarPage(widget._injector.get<CalendarBloc>(),title: 'Events'),
        ChatLobbyPage(widget._injector.get<ChatLobbyBloc>(), title: "Chat lobby")
      ],
    );
  }


}
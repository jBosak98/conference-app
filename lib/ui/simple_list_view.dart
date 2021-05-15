import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleListView extends StatelessWidget {

  final List<Widget> children;

  const SimpleListView({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: ListView(children: children)))
          ],
        ));
  }
}
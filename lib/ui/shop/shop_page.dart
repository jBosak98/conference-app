import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../simple_container.dart';
import '../simple_list_view.dart';

class ShopPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShopPageState();

}

class _ShopPageState extends State<ShopPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Shop"),
        ),
        body: SimpleListView(
          children: [...["T-shirt", "Ticket"]
              .map<Widget>((item)=> SimpleContainer(false,children:[Text(item)]))
              .toList()],
        )
    );
  }




}
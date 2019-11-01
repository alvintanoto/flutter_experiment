import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  Navigation({this.length, this.positionNow});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int length;
  final int positionNow;

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      width: 23,
      child: ListView.builder(
          itemCount: widget.length,
          itemBuilder: (context, position) {
            return Container(
              margin: EdgeInsets.only(top: 24),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: position==widget.positionNow?Colors.black:Colors.white),
            );
          }),
    );
  }
}

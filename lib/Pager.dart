import 'package:flutter/material.dart';

class Pager extends StatefulWidget {
  Pager({this.title, this.color, this.curPos});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int curPos;
  final String title;
  final Color color;

  @override
  PagerState createState() => PagerState();
}

class PagerState extends State<Pager> {
  int curPos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curPos = widget.curPos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.color,
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Text(widget.title),
            ),
            Center(
              child: Text(
                "Current Position is $curPos",
                style: TextStyle(fontSize: 24),
              ),
            )
          ],
        ));
  }
}

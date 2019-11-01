import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_experiment/Pager.dart';
import 'package:flutter_experiment/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  var pagerChild = List<Widget>();

  //get color list
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();

  var pageView;
  var pageNow;
  var tempCurPage;

  PageController pageController;

  PageController setPageController(counter) {
    pageController = new PageController(
        initialPage: counter, keepPage: true, viewportFraction: 1)..addListener(pagerListener);
    return pageController;
  }

  void setPageNow(position) {
    setState(() {
      pageNow = position;
    });
  }

  void addViewPager() {
    setState(() {
      counter++;
      if(counter==1){
        setPageNow(0);
      }
    });
  }

  pagerListener() {
//    if((pageController.page%1!=0)==false){
//      setPageNow(pageController.page.round());
//    }
//    print(pageController.page.round());

    if((tempCurPage>pageController.page.round() || tempCurPage<pageController.page.round()) && tempCurPage!=pageController.page.round()){
      tempCurPage = pageController.page.round();
      setPageNow(tempCurPage);
    }

//    setPageNow(pageController.page.round());
//    setPageNow();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempCurPage=0;
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
//        pagerChild.length>0?pageView:Container(),
            PageView.builder(
                itemCount: counter,
                scrollDirection: Axis.vertical,
                controller:setPageController(counter),
                itemBuilder: (context, position) {
                  var positionNow = position + 1;
                  return Pager(title: 'Posisi ke $positionNow',
                    color: colors[position%3],
                    curPos: position,);
                }
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Navigation(length: counter, positionNow:pageNow),
            ),
            Container(
              margin: EdgeInsets.all(24),
              child: new Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: addViewPager,
                  backgroundColor: Colors.blue,
                  child: Text('$counter'),
                ),
              ),
            ),
          ],
        ));
  }
}

import 'dart:io';

import 'package:VTOP_Extended/UI/web.dart';
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:web_browser/web_browser.dart';
import 'Page1.dart';
import 'Page3.dart';
import 'Page4.dart';

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VTOP-Extended',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'VTOP-Extended'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex;

  Widget bodyWidget;

  Scaffold ob;
  Widget bodyINIT(String k) {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebBrowser(
            initialUrl: k,
            javascriptEnabled: true,
          ),
        ),
      ),
    ));
  }

  /*void bodyVTOP1() {
    wb = WebBrowser(
      initialUrl: 'http://vtop2.vitap.ac.in:8070/vtop/initialProcess',
      javascriptEnabled: true,
    );
  }

  void bodyCal1() {
    wb = WebBrowser(
      initialUrl: 'https://vitap.ac.in/academic-calendar/',
      javascriptEnabled: true,
    );
  }

  void bodyExam1() {
    wb = WebBrowser(
      initialUrl: 'http://vtop2.vitap.ac.in:8070/onlineexam/login',
      javascriptEnabled: true,
    );
  }

  void bodyMenu1() {
    wb = WebBrowser(
      initialUrl: 'https://vitap.ac.in',
      javascriptEnabled: true,
    );
  }

  Widget bodyVTOP() {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebBrowser(
            initialUrl: 'http://vtop2.vitap.ac.in:8070/vtop/initialProcess',
            javascriptEnabled: true,
          ),
        ),
      ),
    ));
  }

  Widget bodyCal() {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebBrowser(
            initialUrl: 'https://vitap.ac.in/academic-calendar/',
            javascriptEnabled: true,
          ),
        ),
      ),
    ));
  }

  Widget bodyExam() {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebBrowser(
            initialUrl: 'http://vtop2.vitap.ac.in:8070/onlineexam/login',
            javascriptEnabled: true,
          ),
        ),
      ),
    ));
  }

  Widget bodyMenu() {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: WebBrowser(
            initialUrl: 'https://vitap.ac.in',
            javascriptEnabled: true,
          ),
        ),
      ),
    ));
  }

  Widget bodyReload() {
    return Center(
        child: MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: wb,
        ),
      ),
    ));
  }*/

  @override
  void initState() {
    // TODO: implement initState
    //buildscf();
    bodyWidget = bodyINIT('https://vitap.ac.in/academic-calendar/');

    super.initState();
    currentIndex = 1;
  }

  void changePage(int index) {
    /*
    if (index == 0) {
      //bodyWidget = bodyVTOP();
      //bodyVTOP1();
      bodyWidget = bodyWidget1;
    }
    if (index == 1) {
      //bodyWidget = bodyCal();
      //bodyCal1();
      bodyWidget = bodyWidget2;
    }
    if (index == 2) {
      //bodyWidget = bodyExam();
      //bodyExam1();
      bodyWidget = bodyWidget3;
    }
    if (index == 3) {
      //bodyWidget = bodyMenu();
      //bodyMenu1();
      bodyWidget = bodyWidget4;
    }
    //wb.createState();
    //bodyWidget = bodyReload();
    //var state = bodyWidget.createState();*/
    setState(() {
      //currentIndex = index;
      if (index == 0) {
        runApp(MyApp1());
      }
      if (index == 2) {
        runApp(MyApp3());
      }
      if (index == 3) {
        runApp(MyApp4());
      }
      // exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    ob = Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: bodyWidget,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(
                16)), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("VTOP")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.deepPurple,
              ),
              title: Text("Calendar")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.folder_open,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.folder_open,
                color: Colors.indigo,
              ),
              title: Text("Exam")),
          BubbleBottomBarItem(
              backgroundColor: Colors.green,
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.menu,
                color: Colors.green,
              ),
              title: Text("Menu"))
        ],
      ),
    );
    return ob;
  }
}

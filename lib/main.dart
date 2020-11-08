import 'package:VTOP_Extended/UI/web.dart';
import 'package:flutter/material.dart';
import 'UI/SplashScreen.dart';
import 'UI/Page1.dart';
import 'UI/web.dart';
import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

void main() {
  runApp(SplashScr());
  runApp(MyApp1());
  //runApp(MaterialApp(home: WebViewExample()));
  /*runApp(MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: WebBrowser(
          initialUrl: 'http://vtop2.vitap.ac.in:8070/vtop/initialProcess',
          javascriptEnabled: true,
        ),
      ),
    ),
  ));*/
}

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../main.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Quiz"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: InAppWebView(
          initialUrl: "http://vtop1.vitap.ac.in:8080/onlineexam/login",
          initialHeaders: {},
          onWebViewCreated: (InAppWebViewController controller) {
            //webView = controller;
          },
        ),
      ),
    );
  }
}

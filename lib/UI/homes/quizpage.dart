import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(2.0),
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
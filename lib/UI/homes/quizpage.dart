import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: WebView(
          initialUrl: "http://vtop1.vitap.ac.in:8080/onlineexam/login",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
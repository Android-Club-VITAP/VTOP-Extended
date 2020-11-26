import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class VtopPage extends StatefulWidget {
  @override
  _VtopPageState createState() => _VtopPageState();
}

class _VtopPageState extends State<VtopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child:  InAppWebView(
        initialUrl: "http://vtop2.vitap.ac.in:8070/vtop/",
        initialHeaders: {},
        onWebViewCreated: (InAppWebViewController controller) {
          //webView = controller;
        },
               
      ),      ),
    );
  }
}
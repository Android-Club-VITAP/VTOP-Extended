import 'package:VTOP_Extended/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VtopPage extends StatefulWidget {
  @override
  _VtopPageState createState() => _VtopPageState();
}

class _VtopPageState extends State<VtopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("VTOP"),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: InAppWebView(
          initialUrl: "http://vtop2.vitap.ac.in:8070/vtop/",
          initialHeaders: {},
          onWebViewCreated: (InAppWebViewController controller) {
            //webView = controller;
          },
        ),
      ),
    );
  }
}

import 'package:VTOP_Extended/models/user.dart';
import 'package:VTOP_Extended/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/SplashScreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: SplashScr(),
      ),
    );
  }
}

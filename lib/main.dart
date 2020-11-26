import 'package:VTOP_Extended/models/user.dart';
import 'package:VTOP_Extended/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/SplashScreen.dart';

void main() => runApp(App());
final backgroundColor = Color(0xFF2c2c2c);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
          canvasColor: backgroundColor,
        ),
        home: SplashScr(),
      ),
    );
  }
}

import 'package:VTOP_Extended/UI/homes/faculty_db.dart';
import 'package:VTOP_Extended/UI/homes/myaccountpage.dart';
import 'package:VTOP_Extended/UI/homes/quizpage.dart';
import 'package:VTOP_Extended/UI/homes/vtoppage.dart';
import 'package:VTOP_Extended/models/user.dart';
import 'package:VTOP_Extended/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/SplashScreen.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());
final backgroundColor = Color(0xFF2c2c2c);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: backgroundColor,
        ),
        routes: {
          'Accounts': (context) => MyAccountsPage(),
          'Vtop': (context) => VtopPage(),
          'quiz': (context) => QuizPage(),
          'FacD': (context) => FacultyDB(),
        },
        home: SplashScr(),
      ),
    );
  }
}

// TODO: FIX UI. COLORS. EVERYTHING. LIFE.

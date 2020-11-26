import 'package:VTOP_Extended/UI/homes/activities.dart';
import 'package:VTOP_Extended/UI/homes/myaccountpage.dart';
import 'package:VTOP_Extended/UI/homes/quizpage.dart';
import 'package:VTOP_Extended/UI/homes/vtoppage.dart';
import 'package:VTOP_Extended/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:VTOP_Extended/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DrawerItem {
  String title;
  IconData icon;
  Color color;
  DrawerItem(this.title, this.icon, this.color);
}

class ExtendedHome extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("My Account", AntDesign.user, Colors.red),
    new DrawerItem("Events & Clubs", Entypo.star_outlined, Colors.blue),
    new DrawerItem("VTOP", AntDesign.weibo_circle, Colors.amber),
    new DrawerItem("Quiz", AntDesign.form, Colors.indigo),
    new DrawerItem("Teacher Database", Entypo.database, Colors.green),
    new DrawerItem("About", Entypo.notification, Colors.white),
    new DrawerItem("Logout", Entypo.log_out, Colors.purple),
  ];

  @override
  _ExtendedHomeState createState() => _ExtendedHomeState();
}

class _ExtendedHomeState extends State<ExtendedHome> {
  int _selectedDrawerIndex = 1;
  final titles = [
    new Text("Account Management"),
    new Text(
      "Extended",
      style: TextStyle(
          letterSpacing: 6,
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold),
    ),
    new Text("VTOP"),
    new Text("Quiz"),
    new Text("Teachers"),
    new Text("About the App"),
    new Text("Logout")
  ];

  bool _isEmailVerified = false;
  void _checkEmailVerification() async {
    _isEmailVerified = await _auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    _auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resend link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    email = user.email;
    name = user.displayName;
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MyAccountsPage();
      case 1:
        return new Activities();
      case 2:
        return new VtopPage();
      case 3:
        return new QuizPage();
      case 6:
        return signOut();
      default:
        return Center(
            child: new Text(
          "Page under construction!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
      dispose();
    } catch (e) {
      print(e);
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  final AuthService _auth = AuthService();
  String name;
  String email;
  FirebaseUser user;
  FirebaseAuth auth;
  final backgroundColor = Color(0xFF2c2c2c);
  final firstTabColor = Color(0xFF1d1d1d);
  final drawerColor = Color(0xFF545353);

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    // getCurrentUser();
    _checkEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(
          d.icon,
          color: d.color,
        ),
        title: new Text(
          d.title,
          style: TextStyle(color: Colors.white),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: titles[_selectedDrawerIndex],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: firstTabColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              accountName:
                  name == null ? Text("Unknown") : Text(user.displayName),
              accountEmail:
                  email == null ? Text("Email Not found") : Text(user.email),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

// class Home extends StatelessWidget {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<QuerySnapshot>.value(
//       value: DatabaseService().users,
//       child: Scaffold(
//         backgroundColor: Colors.brown[50],
//         appBar: AppBar(
//           title: Text("VTOP-Extended"),
//           backgroundColor: Colors.brown[400],
//           elevation: 0.0,
//           actions: <Widget>[
//             FlatButton.icon(
//                 onPressed: () async {
//                   await _auth.signOut();
//                 },
//                 icon: Icon(Icons.person),
//                 label: Text("Log Out"))
//           ],
//         ),
//         body: Container(),
//       ),
//     );
//   }
// }

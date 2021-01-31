import 'package:VTOP_Extended/UI/homes/activities.dart';
import 'package:VTOP_Extended/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:VTOP_Extended/services/database.dart';
// import 'package:provider/provider.dart';
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
    new DrawerItem("Faculty Database", Entypo.database, Colors.green),
    new DrawerItem("About", Entypo.notification, Colors.white)
  ];

  @override
  _ExtendedHomeState createState() => _ExtendedHomeState();
}

class _ExtendedHomeState extends State<ExtendedHome> {
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
    User user = await _auth.currentUser();
    email = user.email;
    name = await FirebaseFirestore.instance.collection("users").doc(user.uid).get()
        // ignore: missing_return
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data()['name'].toString();
      }
    });
    (context as Element).reassemble();
  }

  signOut() async {
    try {
      await _auth.signOut();
      dispose();
    } catch (e) {
      print(e);
    }
  }

  final AuthService _auth = AuthService();
  String name;
  String email;
  User user;
  FirebaseAuth auth;
  final backgroundColor = Color(0xFF2c2c2c);
  final firstTabColor = Color(0xFF1d1d1d);
  final drawerColor = Color(0xFF545353);

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    getCurrentUser();
    _checkEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.notification_important_outlined), onPressed: () => Navigator.pushNamed(context, 'Notifications'))
        ],
        title: Text(
          "Extended",
          style: TextStyle(
              letterSpacing: 6,
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
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
              accountName: name == null ? Text("Unknown") : Text(name),
              accountEmail:
                  email == null ? Text("Email Not found") : Text(email),
            ),
            new Column(children: [
              ListTile(
                leading: Icon(
                  AntDesign.user,
                  color: Colors.red,
                ),
                title: Text(
                  "My Accounts",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'Accounts');
                },
              ),
              ListTile(
                leading: Icon(
                  AntDesign.weibo_circle,
                  color: Colors.amber,
                ),
                title: Text(
                  "VTOP",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, 'Vtop');
                },
              ),
              ListTile(
                  leading: Icon(
                    AntDesign.form,
                    color: Colors.indigo,
                  ),
                  title: Text(
                    "QUIZ",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'quiz');
                  }),
              ListTile(
                  leading: Icon(
                    Entypo.database,
                    color: Colors.green,
                  ),
                  title: Text(
                    "Faculty Database",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'FacD');
                  }),
              ListTile(
                leading: Icon(
                  Entypo.notification,
                  color: Colors.red,
                ),
                title: Text(
                  "About",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  debugPrint("HEHEHEHEHEHEHHE");
                  Navigator.of(context).pop();
                },
              ),
            ])
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: Activities(),
    );
  }
}

import 'package:VTOP_Extended/UI/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MyAccountsPage extends StatefulWidget {
  @override
  _MyAccountsPageState createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  String name;
  String finalname;
  String email;
  String rollno;
  String finalroll;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _regController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getName();
    getEmail();
  }

  updateProfileName(name) async {
    FirebaseUser user = await _auth.currentUser();
    user.reload();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    if (user != null) {
      user.updateProfile(userUpdateInfo);
    }
    print(user.displayName);
    Firestore.instance
        .collection("users")
        .document(user.uid)
        .updateData({"name": name}).catchError((e) {
      print(e.toString());
    });
    getName();
  }

  updateRollno(rollno) async {
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance
        .collection("users")
        .document(user.uid)
        .updateData({"rollno": rollno}).catchError((e) {
      print(e.toString());
    });
    getName();
  }

  getName() async {
    FirebaseUser user = await _auth.currentUser();
    finalname = await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data['name'].toString();
      }
    });
    finalroll = await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data['rollno'].toString();
      }
    });
    (context as Element).reassemble();
  }

  getEmail() async {
    FirebaseUser user = await _auth.currentUser();
    email = user.email;
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 50),
                  child: Text(
                    "Email: $email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: Text(
                    finalname == null ? "Name: Unknown" : "Name: $finalname",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10, bottom: 30),
                  child: Text(
                    finalroll == "Rollno"
                        ? "Roll no: Unknown"
                        : "Roll no: $finalroll",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    controller: _emailController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      labelText: email,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _nameController,
                    cursorColor: Colors.blue,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a Valid Name";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.blue,
                      icon: Icon(
                        Feather.user,
                        color: Colors.white,
                      ),
                      labelText: "Enter new name",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => rollno = val);
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _regController,
                    cursorColor: Colors.blue,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter a Valid Rollno";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.blue,
                      icon: Icon(
                        Feather.user,
                        color: Colors.white,
                      ),
                      labelText: "Enter rollno",
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Container(
                      color: Colors.blue,
                      child: FlatButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            try {
                              setState(() {
                                updateProfileName(name);
                                updateRollno(rollno);
                                _formKey.currentState.reset();
                                _nameController.clear();
                                _regController.clear();
                                getName();
                              });
                            } catch (e) {
                              print(e.toString());
                            }
                          }
                        },
                        child:
                            Text("Save", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.0, right: 3.0, top: 75),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Colors.deepOrangeAccent,
                      child: FlatButton(
                        onPressed: () async {
                          signOut();
                        },
                        child: Text("Logout",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

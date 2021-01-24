import 'package:VTOP_Extended/main.dart';
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
    finalname =
        await Firestore.instance.collection("users").document(user.uid).get()
            // ignore: missing_return
            .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data['name'].toString();
      }
    });
    finalroll =
        await Firestore.instance.collection("users").document(user.uid).get()
            // ignore: missing_return
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
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text("Accounts"),
      ),
      resizeToAvoidBottomInset: false,
      body: Scrollbar(
        thickness: 2,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Email: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[700],
                        ),
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text(
                            email == null ? "-----" : email,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      "Name: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[700],
                        ),
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text(
                            finalname == null ? "-----" : finalname,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      top: 10,
                    ),
                    child: Text(
                      "Roll no: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 40),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Colors.grey[700],
                        ),
                        height: 50,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: Text(
                            finalroll == null ? "-----" : finalroll,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 20),
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
                          color: Colors.blue,
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
                          color: Colors.red,
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
                          Feather.tag,
                          color: Colors.purple,
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.blue[700],
                        ),
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
                          child: Text("Save",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 3.0, right: 3.0, top: 35, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.deepOrange,
                        ),
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: FlatButton(
                          onPressed: () async {
                            signOut();
                            Navigator.pop(context);
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
      ),
    );
  }
}

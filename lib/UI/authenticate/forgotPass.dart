import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool validatAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Future<void> resetPassword(String email) async {
    if (validatAndSave()) {
      setState(() {
        loading = true;
      });
      try {
        await _auth.sendPasswordResetEmail(email: _email);
        setState(() {
          loading = false;
          String errorMsg = "Password reset link sent to email id please check";
          showDialog(
              context: context,
              builder: (BuildContext alertcontext) {
                return AlertDialog(
                  content: Container(
                    child: Text(errorMsg),
                  ),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.pop(alertcontext);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        });
      } catch (e) {
        setState(() {
          loading = false;
          Flushbar(
            borderRadius: 8.0,
            title: "Email not found in database",
            message: "Please recheck email",
            flushbarPosition: FlushbarPosition.BOTTOM,
            flushbarStyle: FlushbarStyle.FLOATING,
            reverseAnimationCurve: Curves.decelerate,
            forwardAnimationCurve: Curves.bounceIn,
            backgroundColor: Colors.black,
            mainButton: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                )),
            margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
            isDismissible: true,
            duration: Duration(seconds: 10),
            icon: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
          )..show(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black87,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/void.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.37), BlendMode.darken),
          fit: BoxFit.cover,
        )),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.033,
                      left: MediaQuery.of(context).size.width * 0.03),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: MediaQuery.of(context).size.width * 0.1),
                  child: Text(
                    "Reset here :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      left: MediaQuery.of(context).size.width * 0.066,
                      right: MediaQuery.of(context).size.width * 0.066),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 2.0)),
                    ),
                    validator: (val) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!(regex.hasMatch(val) &&
                          val.isNotEmpty &&
                          val.contains("vitap.ac.in")))
                        return "Please enter a valid Email-ID";
                      else
                        return null;
                    },
                    onChanged: (val) {
                      setState(() => _email = val);
                    },
                  ),
                ),
                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1,
                          left: MediaQuery.of(context).size.width * 0.066,
                          right: MediaQuery.of(context).size.width * 0.066),
                      child: ElevatedButton(
                        // color: Colors.blue,
                        onPressed: () {
                          resetPassword(_email);
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        // elevation: 25,
                      )),
                ),
                SizedBox(
                  height: 40,
                ),
                loading
                    ? Center(
                        child: Text(
                        'Please wait...',
                        style: TextStyle(color: Colors.white),
                      ))
                    : Container()
              ],
            )),
      ),
    );
  }
}

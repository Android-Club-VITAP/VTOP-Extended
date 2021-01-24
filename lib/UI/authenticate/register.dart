import 'package:VTOP_Extended/UI/loading.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:VTOP_Extended/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String cnfpass = '';
  String error = '';

  bool validatAndSave() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                        image: AssetImage('assets/images/Space.png'),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.66), BlendMode.darken),
                        fit: BoxFit.cover)),
                child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.15,
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.125,
                              left: MediaQuery.of(context).size.width * 0.066,
                              right: MediaQuery.of(context).size.width * 0.066),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Enter VIT-AP Email",
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (val) {
                              Pattern pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex = new RegExp(pattern);
                              if (!(regex.hasMatch(val) &&
                                  val.isNotEmpty &&
                                  val.contains('vitap.ac.in')))
                                return "Please enter a valid Email-ID";
                              else
                                return null;
                            },
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.025,
                              left: MediaQuery.of(context).size.width * 0.066,
                              right: MediaQuery.of(context).size.width * 0.066),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Enter a Password",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0))),
                            validator: (value) {
                              if (value.length < 6) {
                                return "Enter more than 6 Characters";
                              } else
                                return null;
                            },
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.025,
                              left: MediaQuery.of(context).size.width * 0.066,
                              right: MediaQuery.of(context).size.width * 0.066),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Re-Enter the Password",
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 2.0))),
                            validator: (value) {
                              if (value != password) {
                                return "Passwords Don't Match!";
                              } else
                                return null;
                            },
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => cnfpass = val);
                            },
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.9,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.width * 0.066,
                                right:
                                    MediaQuery.of(context).size.width * 0.066),
                            child: RaisedButton(
                              color: Colors.pink,
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() => loading = true);
                                  try {
                                    dynamic result = await await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        Flushbar(
                                          borderRadius: 8.0,
                                          title: "Error Authenticating",
                                          message:
                                              "Please enter correct Email and Password",
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          flushbarStyle: FlushbarStyle.FLOATING,
                                          reverseAnimationCurve:
                                              Curves.decelerate,
                                          forwardAnimationCurve:
                                              Curves.bounceIn,
                                          backgroundColor: Colors.black,
                                          mainButton: FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          margin: EdgeInsets.only(
                                              bottom: 8, left: 8, right: 8),
                                          isDismissible: true,
                                          duration: Duration(seconds: 10),
                                          icon: Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                          ),
                                        )..show(context);
                                      });
                                    }
                                  } catch (error) {
                                    print(error);
                                  }
                                }
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900),
                              ),
                              elevation: 25,
                            )),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.08,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05,
                                left: MediaQuery.of(context).size.width * 0.18,
                                right:
                                    MediaQuery.of(context).size.width * 0.18),
                            child: RichText(
                                text: TextSpan(
                                    text: "Already have an account : ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                    children: <TextSpan>[
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          widget.toggleView();
                                        },
                                      text: "Log In",
                                      style: TextStyle(
                                          shadows: <Shadow>[
                                            Shadow(
                                              color: Colors.cyanAccent,
                                              blurRadius: 5.0,
                                              offset: Offset(0.0, 0.0),
                                            )
                                          ],
                                          color: Colors.cyanAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800))
                                ])),
                          ),
                        )
                      ],
                    ))),
          );
  }
}

import 'package:VTOP_Extended/UI/authenticate/authenticate.dart';
import 'package:VTOP_Extended/UI/homes/home.dart';
import 'package:VTOP_Extended/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return ExtendedHome();
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockx/pages/pageUser/profile.dart';
import 'package:stockx/pages/pageUser/register.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/pages/user_page.dart';

import 'package:stockx/theme/colors.dart';

class RootUserLogin extends StatefulWidget {
  const RootUserLogin({Key? key}) : super(key: key);

  @override
  State<RootUserLogin> createState() => _RootUserLoginState();
}

class _RootUserLoginState extends State<RootUserLogin> {
  @override
  final _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return Scaffold(
        body: UserPage(),
      );
    } else {
      return Scaffold(
        body: ProfilePage(),
      );
    }
    ;
  }
}

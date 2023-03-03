// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stockx/pages/pageUser/editUser/edit.dart';
import 'package:stockx/pages/pageUser/register.dart';
import 'package:stockx/pages/pageUser/rootLogin.dart';
import 'package:stockx/pages/pageUser/sell/UserSell/addProductSell.dart';
import 'package:stockx/pages/root_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User user = FirebaseAuth.instance.currentUser;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? RootApp() : RootUserLogin(),
      // home: AddProductSell(),
    ),
  );
}

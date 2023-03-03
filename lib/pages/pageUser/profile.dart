import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/pageUser/buying/historyBuying.dart';
import 'package:stockx/pages/pageUser/chat/chatSeller.dart';
import 'package:stockx/pages/pageUser/chat/listChat.dart';
import 'package:stockx/pages/pageUser/editUser/profileUser.dart';
import 'package:stockx/pages/pageUser/rootLogin.dart';
import 'package:stockx/pages/pageUser/sell/UserSell/sell.dart';
import 'package:stockx/pages/pageUser/sell/buyP2P/sellP2P.dart';
import 'package:stockx/pages/pageUser/sercurity/security.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/pages/user_page.dart';
import 'package:stockx/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  signOut() async {
    await _firebaseAuth.signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => RootUserLogin()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ListView(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Profile')
                .orderBy('icon', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: List.generate(
                  snapshot.data!.docs.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => ProfileUser()));
                            break;
                          case 1:
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => Sercurity()));
                            break;
                          case 2:
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => HistoryBuying()));
                            break;
                          case 3:
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => UserSell()));
                            break;
                          case 4:
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => ListChat()));
                            break;
                          case 5:
                            print("check");
                            break;
                          case 6:
                            print("check");
                            break;
                          case 7:
                            print("check");
                            break;
                          case 8:
                            print("check");
                            break;
                          case 9:
                            print("check");
                            break;
                          case 10:
                            print("check");
                            break;

                          case 11:
                            print("check");

                            break;
                          case 12:
                            signOut();

                            break;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.grey,
                        )),
                        child: Row(
                          children: [
                            if (snapshot.data!.docs[index].get('icon') == 1)
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 2)
                              Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 3)
                              Icon(
                                Icons.shopping_bag,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 4)
                              Icon(
                                Icons.delivery_dining,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 5)
                              Icon(
                                Icons.chat,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 6)
                              Icon(
                                Icons.check,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 7)
                              Icon(
                                Icons.settings,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 8)
                              Icon(
                                Icons.book,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 9)
                              Icon(
                                Icons.question_answer_rounded,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 10)
                              Icon(
                                Icons.newspaper,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 11)
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 12)
                              Icon(
                                Icons.currency_exchange,
                                color: Colors.grey,
                                size: 60,
                              ),
                            if (snapshot.data!.docs[index].get('icon') == 13)
                              Icon(
                                Icons.logout,
                                color: Colors.grey,
                                size: 60,
                              ),
                            Container(
                              height: 70,
                              margin:
                                  EdgeInsets.only(left: 6, top: 5, bottom: 5),
                              width: 270,
                              child: Column(
                                children: [
                                  Container(
                                    width: 350,
                                    child: Text(
                                      snapshot.data!.docs[index].get('name'),
                                      style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 350,
                                    child: Text(
                                      snapshot.data!.docs[index].get('note'),
                                      style: TextStyle(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

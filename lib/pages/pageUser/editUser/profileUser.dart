import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/pages/pageUser/editUser/edit.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/theme/colors.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 240, 240),
      appBar: getAppbar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.person, size: 25),
                        ),
                        TextSpan(
                          text: "PROFILE ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUser(
                            firstname: snapshot.data!.docs[0].get('firstname'),
                            lastname: snapshot.data!.docs[0].get('lastname'),
                            username: snapshot.data!.docs[0].get('username'),
                            size: snapshot.data!.docs[0].get('size'),
                            email: snapshot.data!.docs[0].get('email'),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 15),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: user?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Container(
                        margin: EdgeInsets.only(left: 25, top: 15),
                        child: Column(
                          children: [
                            Text(
                              "NAME",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data!.docs[0].get('firstname'),
                              style: TextStyle(
                                color: Color.fromARGB(255, 122, 121, 121),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: user?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data!.docs[0].get('size') != "") {
                        return Container(
                          margin: EdgeInsets.only(top: 15, right: 135),
                          child: Column(
                            children: [
                              Text(
                                "SHOES SIZE",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Text(
                                  snapshot.data!.docs[0].get('size'),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 122, 121, 121),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 150),
                              child: Column(
                                children: [
                                  Text(
                                    "SHOE SIZE",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "--",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: user?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 25, top: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 130),
                                  child: Text(
                                    "EMAIL",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 80),
                                  child: Text(
                                    "USERNAME",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 50),
                                  child: Text(
                                    snapshot.data!.docs[0].get('email'),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 122, 121, 121),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 130),
                                  child: Text(
                                    snapshot.data!.docs[0].get('username'),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 122, 121, 121),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Text(
                "Account",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              "Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text("check"),
        ],
      ),
    );
  }
}

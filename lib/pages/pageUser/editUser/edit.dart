import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stockx/theme/colors.dart';

class EditUser extends StatefulWidget {
  const EditUser(
      {required this.firstname,
      required this.lastname,
      required this.username,
      required this.size,
      required this.email,
      Key? key})
      : super(key: key);
  final String firstname;
  final String lastname;
  final String username;
  final String size;
  final String email;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  User? user = FirebaseAuth.instance.currentUser;

  String firstname = "";
  String lastname = "";
  String username = "";
  String email = "";
  String size = "";
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Column(
        children: [
          Divider(color: Colors.grey),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: user?.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              String firstname = snapshot.data!.docs[0].get('firstname');
              String lastname = snapshot.data!.docs[0].get('lastname');
              String username = snapshot.data!.docs[0].get('username');
              String email = snapshot.data!.docs[0].get('email');

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            "FIRST NAME",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 10,
                        color: Colors.black,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            "LAST NAME",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: TextEditingController(text: widget.firstname),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // print(value);
                      firstname = value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: TextEditingController(text: widget.lastname),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value == "") {
                        lastname = widget.lastname;
                      } else {
                        lastname = value;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(
            height: 15,
            color: Color.fromARGB(255, 214, 211, 211),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 300),
                child: Text(
                  "USERNAME",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: TextEditingController(
                    text: widget.username,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value == "") {
                      username = widget.username;
                    } else {
                      username = value;
                    }
                  },
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 240, bottom: 10),
            child: Text(
              "US MEN'S SHOES SIZE",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('SizeSneaker')
                .orderBy('num', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    snapshot.data!.docs.length,
                    (index) {
                      snapshot.data!.docs[index].get('sizename');
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  currentindex = index;
                                  size = snapshot.data!.docs[index]
                                      .get('sizename');

                                  // _hasBeenPressed = !_hasBeenPressed;
                                },
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(left: 15, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(300),
                                color: currentindex == index
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data!.docs[index]
                                      .get('sizename')
                                      .toString()
                                      .substring(5),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Divider(
            height: 15,
            color: Colors.grey,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 260),
                child: Text(
                  "EMAIL ADDRESS",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: TextFormField(
                  controller: TextEditingController(text: widget.email),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (value == "") {
                      email = widget.email;
                    } else {
                      email = value;
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
      bottomSheet: buttonSave(),
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
                "Cancel",
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
              "Edit Profile",
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

  Widget buttonSave() {
    return InkWell(
      onTap: () async {
        User? user = FirebaseAuth.instance.currentUser;
        if (firstname == "") {
          firstname = widget.firstname;
        }
        if (lastname == "") {
          lastname = widget.lastname;
        }
        if (username == "") {
          username = widget.username;
        }
        if (size == "") {
          size = widget.size;
        }
        if (email == "") {
          email = widget.email;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'size': size,
          'email': email,
        });

        Fluttertoast.showToast(msg: "Update  successfully :) ");
      },
      child: Container(
        color: Color.fromARGB(255, 25, 92, 28),
        width: 400,
        height: 50,
        child: Center(
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

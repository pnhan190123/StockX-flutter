import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:stockx/pages/pageUser/sell/UserSell/addProductSell.dart';
import 'package:stockx/theme/colors.dart';

class UserSell extends StatefulWidget {
  const UserSell({Key? key}) : super(key: key);

  @override
  State<UserSell> createState() => _UserSellState();
}

class _UserSellState extends State<UserSell> {
  User? user = FirebaseAuth.instance.currentUser;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  late int amount = 0;
  late double total = 0;
  late int incomplete = 0;
  late int complete = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sell')
            .where('uid', isEqualTo: user?.uid)
            .orderBy('date', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 15),
                          child: Text(
                            "ITEM",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 130, top: 15),
                          child: Text(
                            "SELL DATE",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 45, top: 15),
                          child: Text(
                            "STATUS",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25, top: 15),
                          child: Text(
                            "PRICE",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        "-----------------------------------------------------------------------------------",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 130,
                                            margin: EdgeInsets.only(right: 70),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  .get('name'),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 100,
                                              top: 5,
                                            ),
                                            child: FadeInDown(
                                              delay:
                                                  Duration(milliseconds: 300),
                                              child: Container(
                                                width: 100,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color:
                                                        black.withOpacity(0.1),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .get('img'),
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 140, top: 5),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  .get('size'),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 14),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .get('date')
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      snapshot.data!.docs[index]
                                                  .get('buyDone') ==
                                              0
                                          ? Container(
                                              margin: EdgeInsets.only(left: 40),
                                              child: Text(
                                                "ImComplete",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.only(left: 40),
                                              child: Text(
                                                "Complete",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .get('price'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Text(
                                  "-----------------------------------------------------------------------------------",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: getTotal(),
    );
  }

  Widget getTotal() {
    return Container(
      width: 1000,
      height: 110,
      color: Color.fromARGB(255, 221, 217, 217),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('sell')
            .where('uid', isEqualTo: user?.uid)
            .orderBy('date', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            amount = snapshot.data!.docs.length;
            double check = double.parse(
                snapshot.data!.docs[i].get('price').toString().substring(1));
            if (snapshot.data!.docs[i].get('buyDone') == 0) {
              incomplete += 1;
            } else {
              complete += 1;
            }
            total += check;
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.bar_chart_rounded,
                                  color: Colors.blue,
                                  size: 25,
                                ),
                              ),
                              TextSpan(
                                text: "PURCHASES (\$) ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "\$" + total.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 70),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.tag_sharp,
                                  color: Colors.green,
                                  size: 25,
                                ),
                              ),
                              TextSpan(
                                text: "PURCHASES (\$) ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 130),
                        child: Text(
                          amount.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                  size: 25,
                                ),
                              ),
                              TextSpan(
                                text: "Complete (\$) ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          complete.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 70),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              ),
                              TextSpan(
                                text: "Incomplete (\$) ",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 130),
                        child: Text(
                          incomplete.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
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
              "Sell Product ",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push((context),
                  MaterialPageRoute(builder: (context) => AddProductSell()));
            },
            child: Container(
              child: Text(
                "Add Sell",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

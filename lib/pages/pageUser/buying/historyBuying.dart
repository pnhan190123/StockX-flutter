import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:stockx/theme/colors.dart';

class HistoryBuying extends StatefulWidget {
  const HistoryBuying({Key? key}) : super(key: key);

  @override
  State<HistoryBuying> createState() => _HistoryBuyingState();
}

class _HistoryBuyingState extends State<HistoryBuying> {
  User? user = FirebaseAuth.instance.currentUser;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  late int amount = 0;
  late double total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 15),
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
                margin: EdgeInsets.only(left: 150, top: 15),
                child: Text(
                  "SALE DATE",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15, top: 15),
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
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('order')
                .where('uid', isEqualTo: user?.uid)
                .orderBy('date', descending: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.length == 0) {
                return Text("no data");
              } else {
                return Column(
                  children: List.generate(
                    snapshot.data!.docs.length,
                    (index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Divider(
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 100,
                                        margin: EdgeInsets.only(right: 110),
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
                                        margin:
                                            EdgeInsets.only(right: 110, top: 5),
                                        child: FadeInDown(
                                          delay: Duration(milliseconds: 300),
                                          child: Container(
                                            width: 100,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: black.withOpacity(0.1),
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data!.docs[index]
                                                      .get('img')),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(1)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(right: 150, top: 5),
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
                                    child: Text(
                                      snapshot.data!.docs[index]
                                          .get('date')
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Text(
                                      snapshot.data!.docs[index].get('price'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Divider(
              height: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomSheet: getTotal(),
    );
  }

  Widget getTotal() {
    return Container(
      width: 1000,
      height: 70,
      color: Color.fromARGB(255, 221, 217, 217),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('order')
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
              "History Buying",
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stockx/ProductDetail/productDetail.dart';
import 'package:stockx/pages/orderProduct/detailOrder.dart';
import 'package:stockx/pages/pageUser/sell/buyP2P/orderBuyP2P.dart';
import 'package:stockx/theme/colors.dart';

class BuyP2P extends StatefulWidget {
  const BuyP2P({Key? key}) : super(key: key);

  @override
  State<BuyP2P> createState() => _BuyP2PState();
}

class _BuyP2PState extends State<BuyP2P> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('sell')
                .where('uid', isNotEqualTo: user?.uid)
                .where('buyDone', isEqualTo: 0)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SafeArea(
                child: ListView(
                  children: <Widget>[
                    Wrap(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => OrderBuyP2P(
                                          price: snapshot.data!.docs[index]
                                              .get('price'),
                                          imgUrl: snapshot.data!.docs[index]
                                              .get("img"),
                                          title: snapshot.data!.docs[index]
                                              .get("name"),
                                          size: snapshot.data!.docs[index]
                                              .get("size"),
                                          uid: snapshot.data!.docs[index]
                                              .get("uid"),
                                        )));
                          },
                          child: Container(
                            width: 190,
                            height: 320,
                            child: Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Hero(
                                    tag: snapshot.data!.docs[index].get("name"),
                                    child: Container(
                                      width: (size.width - 16) / 2,
                                      height: (size.width - 16) / 2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data!.docs[index]
                                                  .get("img")),
                                              fit: BoxFit.fitWidth)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("name"),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              height: 1.0,
                                              color: primary,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                .get("brand"),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: medium,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "\$" +
                                                snapshot.data!.docs[index]
                                                    .get("price"),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w800,
                                              color: black,
                                              height: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .where('uid',
                                                    isNotEqualTo: user?.uid)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              return Text(
                                                "User Sell: " +
                                                    snapshot.data!.docs[0]
                                                        .get('username'),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: black,
                                                  height: 1,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              );
            }));
  }
}

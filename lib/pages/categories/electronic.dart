import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/ProductDetail/productDetail.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/theme/colors.dart';

class ElectronicPage extends StatefulWidget {
  const ElectronicPage({Key? key}) : super(key: key);

  @override
  State<ElectronicPage> createState() => _ElectronicPageState();
}

class _ElectronicPageState extends State<ElectronicPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('electronicPage').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: ListView(
              children: <Widget>[
                Wrap(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                      title: snapshot.data!.docs[index]
                                          .get('title'),
                                      note: snapshot.data!.docs[index]
                                          .get('note'),
                                      imgUrl: snapshot.data!.docs[index]
                                          .get('imgUrl'),
                                      price: snapshot.data!.docs[index]
                                          .get('price'),
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
                                tag: snapshot.data!.docs[index].get('title'),
                                child: Container(
                                  width: (size.width - 16) / 2,
                                  height: (size.width - 16) / 2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            snapshot.data!.docs[index]
                                                .get('imgUrl'),
                                          ),
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
                                        snapshot.data!.docs[index].get('title'),
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
                                        snapshot.data!.docs[index].get('note'),
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
                                                .get('price'),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          color: black,
                                          height: 1,
                                        ),
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
        },
      ),
    );
  }
}

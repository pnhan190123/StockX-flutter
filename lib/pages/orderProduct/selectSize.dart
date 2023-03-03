import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/pages/orderProduct/detailOrder.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/theme/colors.dart';

class SelectSize extends StatefulWidget {
  const SelectSize(
      @required this.price, @required this.imgUrl, @required this.title,
      {Key? key})
      : super(key: key);
  final String price;
  final String imgUrl;
  final String title;

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getSizeSneaker(),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 300,
      elevation: 0.0,
      backgroundColor: white,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Onyx",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Text(
                "Canc",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          FadeInDown(
            delay: Duration(milliseconds: 300),
            child: Container(
              width: 280,
              height: 200,
              decoration: BoxDecoration(
                  color: black.withOpacity(0.1),
                  image: DecorationImage(
                    image: NetworkImage(widget.imgUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(1)),
            ),
          ),
          Container(
            width: 500,
            height: 50,
            color: Color.fromARGB(255, 236, 235, 235),
            child: Center(
              child: Text(
                "Select Size",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSizeSneaker() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('SizeSneaker')
          .orderBy('num', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Wrap(
          children: List.generate(snapshot.data!.docs.length, (index) {
            return InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailOrder(
                      price: snapshot.data!.docs[index].get('price'),
                      imgUrl: widget.imgUrl,
                      title: widget.title,
                      size: snapshot.data!.docs[index].get('sizename'),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: grey,
                )),
                margin: EdgeInsets.only(top: 5),
                // color: blue,
                width: 130,
                height: 70,
                child: Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: snapshot.data!.docs[index].get('sizename'),
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: (size.width - 16) / 3,
                          height: (size.width - 220) / 3,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.docs[index].get('sizename'),
                                  style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data!.docs[index].get('price'),
                                  style: TextStyle(
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

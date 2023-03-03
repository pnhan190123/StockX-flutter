import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/orderProduct/OrderSuccessful.dart';
import 'package:stockx/orderProduct/shipingAddress.dart';
import 'package:stockx/theme/colors.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder(
      {required this.title,
      required this.price,
      required this.size,
      required this.imgUrl,
      Key? key})
      : super(key: key);
  final String title;
  final String price;
  final String size;
  final String imgUrl;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(),
      bottomSheet: btnBuy(),
    );
  }

  Widget getBody() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Discount",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  "Add Discount +",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text(
                  "Item Price",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(
                  widget.price,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Text("Final price will be calculated at checkout",
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 5,
            ),
            child: Divider(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ShipingAddress()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Shiping Address",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget btnBuy() {
    return GestureDetector(
      onTap: () async {
        DateTime now = DateTime.now();
        String convertedDateTime =
            "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance.collection('order').add(
          {
            'uid': user?.uid,
            'name': widget.title,
            'size': widget.size,
            'date': convertedDateTime,
            'price': widget.price,
            'img': widget.imgUrl,
          },
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderSuccess(price: widget.price),
          ),
        );
      },
      child: Container(
        height: 50,
        child: Center(
          child: Text(
            "Buy Now",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 70, 21),
        ),
      ),
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
            // color: Colors.blue,
            margin: EdgeInsets.only(left: 120, top: 10),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Highest Bid: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        widget.price,
                        style: TextStyle(
                          color: Color.fromARGB(255, 70, 69, 69),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Size:  ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        widget.size,
                        style: TextStyle(
                          color: Color.fromARGB(255, 70, 69, 69),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

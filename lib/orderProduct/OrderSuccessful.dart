import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/theme/colors.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key, required this.price}) : super(key: key);
  final String price;
  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    String a = widget.price.substring(1);
    var total = double.parse(a) + double.parse('17.95');

    return Scaffold(
      appBar: getAppbar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35),
            child: Center(
              child: (Image.asset(
                'assets/orderSuccess.png',
                fit: BoxFit.fill,
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Text(
              "ORDER CONFIRMED",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            // color: Colors.blue,
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: EdgeInsets.only(top: 35),
                  child: Center(
                    child: (Image.asset(
                      'assets/facebook.jpeg',
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.only(top: 35),
                  child: Center(
                    child: (Image.asset(
                      'assets/twitter.png',
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(top: 35),
                  child: Center(
                    child: (Image.asset(
                      'assets/instagram.jpg',
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.only(top: 35),
                  child: Center(
                    child: (Image.asset(
                      'assets/share.jpg',
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Purchase Price",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      widget.price,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shiping",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "\$ 17,95",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Authentication",
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "FREE",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 35, top: 15),
                height: 15,
                child: Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      total.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 220,
        color: Color.fromARGB(255, 238, 238, 238),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 150, top: 15, bottom: 15),
              child: Text(
                "A few things to remember:",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "The seller is allowed 2 full business days to ship your item to StockX. Weekends and holidays are not business day",
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "Our expert authenticators will verify the product when it arrives at StockX",
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Text(
                "You will receive a tracking number as soon as your item leaves the StockX authentication center",
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      backgroundColor: white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("check"),
          Container(
            child: Text(
              "SUCCESS",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RootApp()));
            },
            child: Container(
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

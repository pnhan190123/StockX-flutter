import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/theme/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            color: backgroundNoti,
            child: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.circle,
                    color: green,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: black.withOpacity(0.1),
                        image: DecorationImage(
                          image: NetworkImage(homeImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: Container(
                      width: 290,
                      margin: EdgeInsets.only(right: 5, bottom: 5, left: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.mail_lock),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Introducing the New Message Centre",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primary,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Every StockX order status, release update, market change and more would be right here waiting for you. Enjoy!")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

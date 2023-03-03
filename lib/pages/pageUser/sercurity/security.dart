import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/theme/colors.dart';

class Sercurity extends StatefulWidget {
  const Sercurity({Key? key}) : super(key: key);

  @override
  State<Sercurity> createState() => _SercurityState();
}

class _SercurityState extends State<Sercurity> {
  bool _checkSpace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: ListView(
        children: [
          CupertinoFormRow(
            prefix: Text(
              'Two-Step Verification',
              style: TextStyle(
                color: Color.fromARGB(255, 134, 127, 127),
              ),
            ),
            child: CupertinoSwitch(
              activeColor: Colors.pink,
              value: _checkSpace,
              onChanged: (value) {
                setState(
                  () {
                    _checkSpace = !_checkSpace;
                  },
                );

                if (_checkSpace == true) {}
              },
            ),
          ),
          Divider(
            height: 15,
            color: Colors.grey,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 160, top: 25, bottom: 10),
                child: Text(
                  "TWO-STEP VERIFICATION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 10, bottom: 10),
                child: Text(
                  "Adding two-step verification improves the overall sercurity of your StockX account by requiring you to enter a code on a trusted mobile device in addition to your password at sign in",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 70, top: 25, bottom: 10),
                child: Text(
                  "Why should I enable two-step verification?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 20, bottom: 10),
                child: Text(
                  "Two-step verification makes your StockX account safer, even if your password is compromised.",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 70, top: 25, bottom: 10),
                child: Text(
                  "What do I need set up two-step verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 20, bottom: 10),
                child: Text(
                  "You need a phone that can recevice text message to enable two-step verification",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 110, top: 25, bottom: 10),
                child: Text(
                  "How do I set up two-step verification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 30, bottom: 10),
                child: Text(
                  "Tap the toggle above to set up two-step verification",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 100, top: 15),
                child: Text(
                  "1.     Enter your mobile phone number",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 80, top: 4),
                child: Text(
                  "2.     We'll send you a one-time code via text",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 100, top: 4),
                child: Text(
                  "3.     Enter the code on the log in screen",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 33, right: 50, top: 4),
                child: Text(
                  "4.     Remember to svae the recovery code so you can sign in if you don't have access to a trusted device",
                  style: TextStyle(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35),
                child: Center(
                  child: (Image.asset(
                    'assets/security.jpg',
                    fit: BoxFit.fill,
                  )),
                ),
              ),
            ],
          )
        ],
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

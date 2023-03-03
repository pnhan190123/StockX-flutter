import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/home_page.dart';
import 'package:stockx/pages/pageUser/login.dart';
import 'package:stockx/pages/pageUser/rootUser.dart';
import 'package:stockx/theme/colors.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: size.width,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(logoStockX),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200, left: 50),
                  child: Text(
                    "Log in or create an account to mangaer your Portfolio, Bids and Asks",
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 290, left: 20),
              child: Container(
                width: 350,
                height: 50,
                color: primary,
                child: InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RootUser()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      width: 70,
                      height: 30,
                      padding: EdgeInsets.only(left: 20, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          child: Text(
                            "SiGN UP",
                            style: TextStyle(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350, left: 20),
              child: Container(
                width: 350,
                height: 50,
                color: white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RootUser()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      width: 70,
                      height: 30,
                      padding: EdgeInsets.only(left: 20, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 420.0),
              child: Container(
                width: 500,
                height: 7,
                color: grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 450.0),
              child: Center(
                child: SizedBox(
                  child: Text(
                    "Blog",
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 490.0),
              child: Center(
                child: SizedBox(
                  child: Text(
                    "Help",
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 530.0),
              child: Center(
                child: SizedBox(
                  child: Text(
                    "How It Works",
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 570.0),
              child: Center(
                child: SizedBox(
                  child: Text(
                    "Reviews",
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 610.0),
              child: Center(
                child: SizedBox(
                  child: Text(
                    "Currency: US\$ USD",
                    style: TextStyle(
                      color: primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

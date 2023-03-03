import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/categories/NTFs.dart';
import 'package:stockx/pages/categories/accessories.dart';
import 'package:stockx/pages/categories/apperal.dart';
import 'package:stockx/pages/categories/collectibles.dart';
import 'package:stockx/pages/categories/electronic.dart';
import 'package:stockx/pages/categories/sneaker.dart';
import 'package:stockx/pages/categories/tradingCart.dart';
import 'package:stockx/pages/pageUser/register.dart';
import 'package:stockx/pages/pageUser/login.dart';
import 'package:stockx/theme/colors.dart';

class RootUser extends StatefulWidget {
  const RootUser({Key? key}) : super(key: key);

  @override
  State<RootUser> createState() => _RootUserState();
}

class _RootUserState extends State<RootUser> {
  @override
  int ActiveTab = 0;

  AppBar appBar = AppBar();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: getBody(),
      body: getIndex(),
    );
  }

  AppBar getBody() {
    var size = MediaQuery.of(context).size;

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0.0,
      backgroundColor: green,
      title: Column(
        children: [
          Center(
            child: (Image.asset(
              "assets/logo.png",
              fit: BoxFit.fill,
            )),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: List.generate(
                  UserManager.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            ActiveTab = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: ActiveTab == index
                                          ? primary
                                          : Colors.transparent,
                                      width: 2))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              UserManager[index],
                              style: TextStyle(
                                fontSize: 17,
                                color: primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getIndex() {
    var size = MediaQuery.of(context).size;

    return IndexedStack(
      index: ActiveTab,
      children: [
        LoginPage(),
        RegisterPage(),
      ],
    );
  }
}

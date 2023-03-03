import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/buyP2P.dart';
import 'package:stockx/pages/home_page.dart';
import 'package:stockx/pages/notification.dart';
import 'package:stockx/pages/pageUser/rootLogin.dart';
import 'package:stockx/pages/search_page.dart';
import 'package:stockx/theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  User? user = FirebaseAuth.instance.currentUser;
  int ActiveTab = 0;
  AppBar appBar = AppBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: getFooter(),
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: white,
          border: Border(top: BorderSide(color: grey.withOpacity(0.2)))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(itemsTab.length, (index) {
            return IconButton(
              icon: Icon(
                itemsTab[index]['icon'],
                size: itemsTab[index]['size'],
                color: ActiveTab == index ? green : black,
              ),
              onPressed: () {
                setState(() {
                  ActiveTab = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    switch (ActiveTab) {
      case 0:
        appBar = AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: white,
          title: Center(
            child: (Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            )),
          ),
        );
        break;
      case 1:
        appBar = AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: white,
          title: Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 50,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'Search by brand, colour etc.',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image.asset(
                      "assets/finder.jpg",
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      case 2:
        appBar = AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Message Centre",
                style: TextStyle(
                  color: primary,
                ),
              ),
              SizedBox(
                child: Container(
                  width: 140,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: green,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Enable Push",
                            style: TextStyle(
                              color: green,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        break;
      case 3:
        appBar = AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: white,
          title: Center(
            child: (Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            )),
          ),
        );
        break;

      case 4:
        appBar = AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.8,
          backgroundColor: white,
          title: Row(
            children: [
              Icon(
                Icons.question_mark,
                color: black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: Text(
                  "Account",
                  style: TextStyle(color: primary),
                ),
              ),
            ],
          ),
        );
        break;

      default:
    }
    return appBar;
  }

  Widget getBody() {
    return IndexedStack(
      index: ActiveTab,
      children: [
        HomePage(),
        SearchPage(),
        NotificationPage(),
        P2PPage(),
        RootUserLogin(),
      ],
    );
  }
}

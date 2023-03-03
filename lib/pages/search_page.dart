import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/categories/NTFs.dart';
import 'package:stockx/pages/categories/accessories.dart';
import 'package:stockx/pages/categories/apperal.dart';
import 'package:stockx/pages/categories/collectibles.dart';
import 'package:stockx/pages/categories/electronic.dart';
import 'package:stockx/pages/categories/tradingCart.dart';
import 'package:stockx/pages/home_page.dart';
import 'package:stockx/pages/categories/sneaker.dart';
import 'package:stockx/theme/colors.dart';

class SearchPage extends StatefulWidget {
  // final int i;

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  int ActiveTab = 0;

  AppBar appBar = AppBar();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: white,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('categories')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: List.generate(
                    snapshot.data!.docs.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ActiveTab = index;
                              // ActiveTab = widget.i;
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
                                snapshot.data!.docs[index].get('title'),
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
                );
              },
            ),
          ),
        ),
      ),
      body: getIndex(),
    );
  }

  Widget getIndex() {
    var size = MediaQuery.of(context).size;

    return IndexedStack(
      index: ActiveTab,
      children: [
        SneakerPage(),
        AppreralPage(),
        ElectronicPage(),
        TradingPage(),
        CollectiblesPage(),
        AccessoriesPage(),
        NFTsPage(),
      ],
    );
  }
}

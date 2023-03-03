import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/pageUser/sell/buyP2P/buyP2P.dart';
import 'package:stockx/pages/pageUser/sell/buyP2P/sellP2P.dart';
import 'package:stockx/theme/colors.dart';

class P2PPage extends StatefulWidget {
  const P2PPage({Key? key}) : super(key: key);

  @override
  State<P2PPage> createState() => _P2PPageState();
}

class _P2PPageState extends State<P2PPage> {
  @override
  int ActiveTab = 0;

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
      elevation: 0.0,
      backgroundColor: white,
      title: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: List.generate(
                  P2P.length,
                  (index) {
                    return Container(
                      // color: Colors.blue,
                      margin: EdgeInsets.only(left: 90),
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
                          child: Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                P2P[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primary,
                                ),
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
        SellP2P(),
        BuyP2P(),
      ],
    );
  }
}

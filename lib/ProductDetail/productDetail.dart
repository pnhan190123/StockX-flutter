import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/categories/sneaker.dart';
import 'package:stockx/pages/orderProduct/selectSize.dart';
import 'package:stockx/theme/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String imgUrl;
  final String note;
  final String price;
  const ProductDetailPage({
    Key? key,
    required this.title,
    required this.imgUrl,
    required this.note,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  int activeSize = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      appBar: getAppbar(),
      body: getBody(),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      toolbarHeight: 220,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: black.withOpacity(0),
                  spreadRadius: 1,
                )
              ],
            ),
            child: Stack(
              children: <Widget>[
                // FadeInDown(
                //   child: ProductSlider(
                //     items: widget.mulImg,
                //   ),
                // ),
                SafeArea(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: black,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: black,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: black,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Dialog(
                      insetPadding: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: grey,
                              )),
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, left: 15),
                                      width: 100,
                                      height: 30,
                                      // color: blue,
                                      child: Text(
                                        "Select Size",
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Size Chart",
                                          style: TextStyle(
                                            color: primary,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: primary,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            getContainer(),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            getSizeSneaker(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 370,
              height: 50,
              padding: EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Size",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "All",
                          style: TextStyle(
                            color: primary,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          SelectSize(widget.price, widget.imgUrl, widget.title),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 1, bottom: 20),
                  width: 170,
                  height: 63,
                  color: Color.fromARGB(255, 3, 71, 38),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$199",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Size: 7.5",
                                style: TextStyle(color: white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Buy",
                              style: TextStyle(color: white, fontSize: 20),
                            ),
                            Text(
                              "Or Bid",
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 1, bottom: 20),
                  width: 170,
                  height: 63,
                  color: Color.fromARGB(255, 231, 22, 32),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$276",
                                style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Size: 5.5",
                                style: TextStyle(color: white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sell",
                              style: TextStyle(color: white, fontSize: 20),
                            ),
                            Text(
                              "Or Ask",
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.black,
          ),
          FadeInDown(
            delay: Duration(milliseconds: 400),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, height: 1.5),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 7),
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 5,
                ),
                width: 130,
                height: 30,
                color: Color.fromARGB(255, 190, 190, 190),
                child: Text(
                  "100% Authentic",
                  style: TextStyle(color: primary, fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 7),
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                  bottom: 5,
                ),
                width: 130,
                height: 30,
                color: Color.fromARGB(255, 190, 190, 190),
                child: Text(
                  "Condition: New",
                  style: TextStyle(color: primary, fontSize: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: black,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.favorite,
                  color: black,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.logout,
                  color: black,
                ),
              ],
            ),
          ),
          FadeInDown(
            delay: Duration(milliseconds: 300),
            child: Container(
              width: 350,
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
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(left: 35, top: 5, bottom: 5),
            width: 350,
            color: grey,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.flash_on,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "This Product is Selling Fast",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "352 Purchases in the past 3 days",
                      style: TextStyle(
                        color: primary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Last Sale:",
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 300),
                    child: Container(
                      // color: blue,
                      width: 90,
                      height: 30,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          "\$" + widget.price,
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    // color: blue,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_upward_sharp,
                          color: green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "\$27 (9,93 %)",
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 150,
                height: 50,
                margin: EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: black,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15,
                    top: 15,
                  ),
                  child: Text(
                    "View Market Data",
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: grey,
            width: 400,
            height: 5,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Related Products",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recommends')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshotRecommends) {
                  if (!snapshotRecommends.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Row(
                    children: List.generate(
                      snapshotRecommends.data!.docs.length,
                      (index) {
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(
                                          title: snapshotRecommends
                                              .data!.docs[index]
                                              .get('title'),
                                          note: snapshotRecommends
                                              .data!.docs[index]
                                              .get('note'),
                                          imgUrl: snapshotRecommends
                                              .data!.docs[index]
                                              .get('imgUrl'),
                                          price: snapshotRecommends
                                              .data!.docs[index]
                                              .get('price'),
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, top: 0),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, bottom: 20),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                bottom: 20,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                height: 265,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: black.withOpacity(0.1),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            snapshotRecommends.data!.docs[index]
                                                .get('imgUrl'),
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 150,
                                      width: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30,
                                            child: Text(
                                              snapshotRecommends
                                                  .data!.docs[index]
                                                  .get('title'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                height: 1.0,
                                                color: primary,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 20,
                                            child: Text(
                                              snapshotRecommends
                                                  .data!.docs[index]
                                                  .get('note'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              "\$" +
                                                  snapshotRecommends
                                                      .data!.docs[index]
                                                      .get('price'),
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                                color: black,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              snapshotRecommends
                                                  .data!.docs[index]
                                                  .get('timesale'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
                width: 370,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Style",
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                    Text(
                      "DD1391-100",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
                width: 370,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Colorway",
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                    Text(
                      "White/Black",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
                width: 370,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Retail Price",
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                    Text(
                      "\$110",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15),
                width: 370,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Release Date",
                      style: TextStyle(
                        color: primary,
                      ),
                    ),
                    Text(
                      "10/03/21",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            height: 150,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "Product Description",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "From the school-spirited Collecge Colors Program to the vibrant Nike Co.JP collection, Nike Dunks have seen many colorways since the design's inception in 1985. But with each",
                  style: TextStyle(
                    color: primary,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Read More",
                    style: TextStyle(
                      color: green,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recently Viewed",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('recently').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshotRecently) {
                if (!snapshotRecently.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: List.generate(
                    snapshotRecently.data!.docs.length,
                    (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                        title: snapshotRecently
                                            .data!.docs[index]
                                            .get('title'),
                                        note: snapshotRecently.data!.docs[index]
                                            .get('note'),
                                        imgUrl: snapshotRecently
                                            .data!.docs[index]
                                            .get('imgUrl'),
                                        price: snapshotRecently
                                            .data!.docs[index]
                                            .get('price'),
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 5, bottom: 20),
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              bottom: 20,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              height: 265,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: black.withOpacity(0.1),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          snapshotRecently.data!.docs[index]
                                              .get('imgUrl'),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 30,
                                          child: Text(
                                            snapshotRecently.data!.docs[index]
                                                .get('title'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              height: 1.0,
                                              color: primary,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 20,
                                          child: Text(
                                            snapshotRecently.data!.docs[index]
                                                .get('note'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: medium,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Text(
                                            "\$" +
                                                snapshotRecently
                                                    .data!.docs[index]
                                                    .get('price'),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w800,
                                              color: black,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Text(
                                            snapshotRecently.data!.docs[index]
                                                .get('timesale'),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: medium,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price History",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 500,
              width: 400,
              child: SfCartesianChart(
                backgroundColor: Colors.white,
                primaryXAxis: DateTimeAxis(
                    visibleMinimum: DateTime(2016, 01, 8),
                    visibleMaximum: DateTime(2016, 03, 16),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    intervalType: DateTimeIntervalType.days,
                    majorGridLines: MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(interval: 4),
                series: <ChartSeries<ChartSampleData, DateTime>>[
                  CandleSeries<ChartSampleData, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (ChartSampleData sales, _) => sales.x,
                    lowValueMapper: (ChartSampleData sales, _) => sales.low,
                    highValueMapper: (ChartSampleData sales, _) => sales.high,
                    openValueMapper: (ChartSampleData sales, _) => sales.open,
                    closeValueMapper: (ChartSampleData sales, _) => sales.close,
                    name: 'Sales',
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.zero,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('time')
                    .orderBy('num', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshottime) {
                  if (!snapshottime.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Row(
                    children: List.generate(
                      snapshottime.data!.docs.length,
                      (index) {
                        return InkWell(
                          onTap: (() {}),
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 5, bottom: 5, right: 5),
                            padding: const EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(2)),
                            child: Container(
                              height: 30,
                              width: 40,
                              padding: EdgeInsets.only(
                                  left: 5, top: 5, bottom: 5, right: 7),
                              child: Text(
                                snapshottime.data!.docs[index].get('key'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: medium,
                                  height: 1,
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
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (() {}),
            child: Container(
              padding: EdgeInsets.only(left: 120, top: 15),
              width: 350,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                color: primary,
              )),
              child: Text(
                "View All Sales",
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "12-Month Historical",
                    style: TextStyle(color: primary, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "12 Month High",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "\$1 022",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "12 Month Low",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "---",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trade Range",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "\$235-\$256",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Volatility",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "4 %",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Number of Sales",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "122 987",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price Premium",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "123 %",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Average Sale Price",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "\$269",
                      style: TextStyle(
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget getContainer() {
    return Container(
      padding: EdgeInsets.only(left: 5),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Container(
            width: 350,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: green,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Text(
                  "All",
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "\$180",
                  style: TextStyle(color: primary),
                ),
              ],
            ),
          ),
        ),
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
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (_) => ProductDetailPage(
                //               title: sneaker[index]['title'],
                //               note: sneaker[index]['note'],
                //               imgUrl: sneaker[index]['imgUrl'],
                //               price: sneaker[index]['price'].toString(),
                //             )));
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

  Widget _buildRow(String imageAsset, String name, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: AssetImage(imageAsset)),
              SizedBox(width: 12),
              Text(name),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow[900],
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text('$score'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stockx/ProductDetail/productDetail.dart';

import 'package:stockx/json/constant.dart';
import 'package:stockx/pages/categories/NTFs.dart';
import 'package:stockx/pages/categories/accessories.dart';
import 'package:stockx/pages/categories/apperal.dart';
import 'package:stockx/pages/categories/collectibles.dart';
import 'package:stockx/pages/categories/electronic.dart';
import 'package:stockx/pages/categories/sneaker.dart';
import 'package:stockx/pages/categories/tradingCart.dart';
import 'package:stockx/pages/root_app.dart';
import 'package:stockx/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  AppBar appBar = AppBar();
  int ActiveTab = 0;

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
      children: <Widget>[
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 0),
              width: size.width,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(homeImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop By Category",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('categories')
                .orderBy('num', descending: false)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotCategories) {
              if (!snapshotCategories.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotCategories.data!.docs.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Scaffold(
                              appBar: getAppBar(),
                              body: CategoryTab[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          children: [
                            Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                color: black.withOpacity(0.1),
                                image: DecorationImage(
                                  image: NetworkImage(snapshotCategories
                                      .data!.docs[index]
                                      .get('imgUrl')),
                                  fit: BoxFit.fitHeight,
                                ),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 200,
                              child: Column(
                                children: [
                                  Text(
                                    snapshotCategories.data!.docs[index]
                                        .get('title'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      height: 1.0,
                                      color: primary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended For You",
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
                FirebaseFirestore.instance.collection('recommends').snapshots(),
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
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                      title: snapshotRecommends
                                          .data!.docs[index]
                                          .get('title'),
                                      note: snapshotRecommends.data!.docs[index]
                                          .get('note'),
                                      imgUrl: snapshotRecommends
                                          .data!.docs[index]
                                          .get('imgUrl'),
                                      price: snapshotRecommends
                                          .data!.docs[index]
                                          .get('price'),
                                    )));
                      }),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshotRecommends.data!.docs[index]
                                          .get('imgUrl'),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshotRecommends.data!.docs[index]
                                          .get('title'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        height: 1.0,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotRecommends.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotRecommends.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotRecommends.data!.docs[index]
                                          .get('timesale'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
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
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Brands",
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
            stream: FirebaseFirestore.instance.collection('brands').snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotBrands) {
              if (!snapshotBrands.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotBrands.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 200,
                              height: 110,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshotBrands
                                      .data!.docs[index]
                                      .get('imgUrl')),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
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
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshotRecently.data!.docs[index]
                                          .get('imgUrl'),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshotRecently.data!.docs[index]
                                          .get('title'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        height: 1.0,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotRecently.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotRecently.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotRecently.data!.docs[index]
                                          .get('timesale'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
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
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Popular Sneaker",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "See All",
                    style: TextStyle(color: green),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: green,
                    size: 16,
                  ),
                ],
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
            stream: FirebaseFirestore.instance
                .collection('mostPopular')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotMostPopular) {
              if (!snapshotMostPopular.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotMostPopular.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                        title: snapshotMostPopular
                                            .data!.docs[index]
                                            .get('title'),
                                        note: snapshotMostPopular
                                            .data!.docs[index]
                                            .get('note'),
                                        imgUrl: snapshotMostPopular
                                            .data!.docs[index]
                                            .get('imgUrl'),
                                        price: snapshotMostPopular
                                            .data!.docs[index]
                                            .get('price'),
                                      )));
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshotMostPopular
                                        .data!.docs[index]
                                        .get('imgUrl')),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshotMostPopular.data!.docs[index]
                                          .get('title'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        height: 1.0,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotMostPopular.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotMostPopular.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotMostPopular
                                                  .data!.docs[index]
                                                  .get('sold'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: 393,
            height: 425,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(advertisement),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Apparel",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: getAppBar(),
                            body: CategoryTab[1],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: green),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: green,
                    size: 16,
                  ),
                ],
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
            stream: FirebaseFirestore.instance
                .collection('appreralPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotAppreal) {
              if (!snapshotAppreal.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotAppreal.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                title: snapshotAppreal.data!.docs[index]
                                    .get("title"),
                                note: snapshotAppreal.data!.docs[index]
                                    .get("note"),
                                imgUrl: snapshotAppreal.data!.docs[index]
                                    .get("imgUrl"),
                                price: snapshotAppreal.data!.docs[index]
                                    .get("price"),
                              ),
                            ),
                          );
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshotAppreal.data!.docs[index]
                                          .get("imgUrl"),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      child: Text(
                                        snapshotAppreal.data!.docs[index]
                                            .get("title"),
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
                                    Text(
                                      snapshotAppreal.data!.docs[index]
                                          .get("note"),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotAppreal.data!.docs[index]
                                              .get("price"),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotAppreal.data!.docs[index]
                                                  .get("sold"),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Electronics Spotlight",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: getAppBar(),
                                body: ElectronicPage(),
                              )));
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(color: green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: green,
                        size: 16,
                      ),
                    ],
                  ),
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
            stream: FirebaseFirestore.instance
                .collection('electronicPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotElectronic) {
              if (!snapshotElectronic.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotElectronic.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                        title: snapshotElectronic
                                            .data!.docs[index]
                                            .get('title'),
                                        note: snapshotElectronic
                                            .data!.docs[index]
                                            .get('note'),
                                        imgUrl: snapshotElectronic
                                            .data!.docs[index]
                                            .get('imgUrl'),
                                        price: snapshotElectronic
                                            .data!.docs[index]
                                            .get('price'),
                                      )));
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshotElectronic
                                        .data!.docs[index]
                                        .get('imgUrl')),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshotElectronic.data!.docs[index]
                                          .get('title'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotElectronic.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotElectronic.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotElectronic
                                                  .data!.docs[index]
                                                  .get('sold'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Trading Cards",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: getAppBar(),
                                body: TradingPage(),
                              )));
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(color: green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: green,
                        size: 16,
                      ),
                    ],
                  ),
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
            stream: FirebaseFirestore.instance
                .collection('TradingCardPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotTradingCard) {
              if (!snapshotTradingCard.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotTradingCard.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailPage(
                                title: snapshotTradingCard.data!.docs[index]
                                    .get('title'),
                                note: snapshotTradingCard.data!.docs[index]
                                    .get('note'),
                                imgUrl: snapshotTradingCard.data!.docs[index]
                                    .get('imgUrl'),
                                price: snapshotTradingCard.data!.docs[index]
                                    .get('price'),
                              ),
                            ),
                          );
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshotTradingCard
                                        .data!.docs[index]
                                        .get('imgUrl')),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshotTradingCard.data!.docs[index]
                                          .get('title'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotTradingCard.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotTradingCard.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotTradingCard
                                                  .data!.docs[index]
                                                  .get('sold'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: 393,
            height: 425,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(advertisement2),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Collectibles Staff Picks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: getAppBar(),
                                body: CollectiblesPage(),
                              )));
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(color: green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: green,
                        size: 16,
                      ),
                    ],
                  ),
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
              stream: FirebaseFirestore.instance
                  .collection('CollectiblesPage')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshotCollectibles) {
                if (!snapshotCollectibles.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Row(
                  children: List.generate(
                    snapshotCollectibles.data!.docs.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, top: 0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(
                                          title: snapshotCollectibles
                                              .data!.docs[index]
                                              .get('title'),
                                          note: snapshotCollectibles
                                              .data!.docs[index]
                                              .get('note'),
                                          imgUrl: snapshotCollectibles
                                              .data!.docs[index]
                                              .get('imgUrl'),
                                          price: snapshotCollectibles
                                              .data!.docs[index]
                                              .get('price'),
                                        )));
                          },
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    color: black.withOpacity(0.1),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshotCollectibles.data!.docs[index]
                                            .get('imgUrl'),
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        // color: blue,
                                        child: Text(
                                          snapshotCollectibles.data!.docs[index]
                                              .get('title'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: primary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshotCollectibles.data!.docs[index]
                                            .get('note'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: medium,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "\$" +
                                            snapshotCollectibles
                                                .data!.docs[index]
                                                .get('price'),
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          color: black,
                                          height: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: Container(
                                          color: grey,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                color: green,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                snapshotCollectibles
                                                    .data!.docs[index]
                                                    .get('sold'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: medium,
                                                  height: 1,
                                                ),
                                              ),
                                            ],
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
                      );
                    },
                  ),
                );
              }),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Featured Accessories",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: getAppBar(),
                                body: AccessoriesPage(),
                              )));
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(color: green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: green,
                        size: 16,
                      ),
                    ],
                  ),
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
            stream: FirebaseFirestore.instance
                .collection('AccessoriesPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotAccessories) {
              if (!snapshotAccessories.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotAccessories.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                        title: snapshotAccessories
                                            .data!.docs[index]
                                            .get('title'),
                                        note: snapshotAccessories
                                            .data!.docs[index]
                                            .get('note'),
                                        imgUrl: snapshotAccessories
                                            .data!.docs[index]
                                            .get('imgUrl'),
                                        price: snapshotAccessories
                                            .data!.docs[index]
                                            .get('price'),
                                      )));
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshotAccessories
                                        .data!.docs[index]
                                        .get('imgUrl')),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Text(
                                        snapshotAccessories.data!.docs[index]
                                            .get('title'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotAccessories.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotAccessories.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotAccessories
                                                  .data!.docs[index]
                                                  .get('sold'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Popular NFTs",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Scaffold(
                                appBar: getAppBar(),
                                body: NFTsPage(),
                              )));
                },
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(color: green),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: green,
                        size: 16,
                      ),
                    ],
                  ),
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
            stream: FirebaseFirestore.instance
                .collection('CollectiblesPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotNFT) {
              if (!snapshotNFT.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotNFT.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                        title: snapshotNFT.data!.docs[index]
                                            .get('title'),
                                        note: snapshotNFT.data!.docs[index]
                                            .get('note'),
                                        imgUrl: snapshotNFT.data!.docs[index]
                                            .get('imgUrl'),
                                        price: snapshotNFT.data!.docs[index]
                                            .get('price'),
                                      )));
                        },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                height: 110,
                                decoration: BoxDecoration(
                                  color: black.withOpacity(0.1),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshotNFT.data!.docs[index]
                                          .get('imgUrl'),
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      child: Text(
                                        snapshotNFT.data!.docs[index]
                                            .get('title'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          color: primary,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotNFT.data!.docs[index].get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$" +
                                          snapshotNFT.data!.docs[index]
                                              .get('price'),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: black,
                                        height: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 100,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Container(
                                        color: grey,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: green,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              snapshotNFT.data!.docs[index]
                                                  .get('timesale'),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: medium,
                                                height: 1,
                                              ),
                                            ),
                                          ],
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
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Release Celendar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    "See All",
                    style: TextStyle(color: green),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: green,
                    size: 16,
                  ),
                ],
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
            stream: FirebaseFirestore.instance
                .collection('AccessoriesPage')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotAccessories) {
              if (!snapshotAccessories.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Row(
                children: List.generate(
                  snapshotAccessories.data!.docs.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: Container(
                        width: 200,
                        height: 340,
                        margin:
                            const EdgeInsets.only(top: 5, left: 5, bottom: 20),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 5, bottom: 15),
                                  child: Text(
                                    "May | 4",
                                    style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 80, top: 5, bottom: 15),
                                  child: Icon(
                                    Icons.add_circle,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 150,
                              height: 110,
                              decoration: BoxDecoration(
                                color: black.withOpacity(0.1),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshotAccessories.data!.docs[index]
                                        .get('imgUrl'),
                                  ),
                                  fit: BoxFit.fitHeight,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 200,
                              height: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshotAccessories.data!.docs[index]
                                        .get('title'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: primary,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Text(
                                      snapshotAccessories.data!.docs[index]
                                          .get('note'),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: medium,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                    width: 70,
                                    height: 30,
                                    padding: EdgeInsets.only(left: 20, top: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: primary,
                                      ),
                                    ),
                                    child: SizedBox(
                                      child: Text(
                                        "ASK",
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  color: primary,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      padding:
                                          EdgeInsets.only(right: 15, top: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primary,
                                        ),
                                      ),
                                      child: SizedBox(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text(
                                            "BID",
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
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 50,
      elevation: 0.0,
      backgroundColor: white,
      title: Row(
        children: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RootApp()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
          Container(
            margin: EdgeInsets.only(left: 100, top: 5),
            child: (Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            )),
          ),
        ],
      ),
    );
  }
}

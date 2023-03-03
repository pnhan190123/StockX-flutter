import 'dart:convert';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockx/pages/orderProduct/selectSize.dart';
import 'package:stockx/pages/orderProduct/shipingAddress.dart';
import 'package:stockx/pages/pageUser/sell/UserSell/uploadImg/ImagePicker.dart';
import 'package:stockx/theme/colors.dart';

class AddProductSell extends StatefulWidget {
  const AddProductSell({Key? key}) : super(key: key);

  @override
  State<AddProductSell> createState() => _AddProductSellState();
}

class _AddProductSellState extends State<AddProductSell> {
  TextEditingController _fname = new TextEditingController();
  TextEditingController _price = new TextEditingController();

  String SizeShoe = "";
  String brand = "";
  String category = "";
  late String randomString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: ListView(
        children: [
          Container(
            // color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
                  child: TextFormField(
                    controller: _fname,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 228, 233),
                      border: OutlineInputBorder(),
                      labelText: 'NameProduct',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
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
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (SizeShoe != "")
                        ? Text(
                            SizeShoe,
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                            ),
                          )
                        : Text(
                            "Size",
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                            ),
                          ),
                    Row(
                      children: [
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
            height: 25,
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
                                        "Select Brand",
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            getBrand(),
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
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (brand != "")
                        ? Text(
                            brand,
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                            ),
                          )
                        : Text(
                            "Brand",
                            style: TextStyle(
                              color: primary,
                              fontSize: 15,
                            ),
                          ),
                    Row(
                      children: [
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
            height: 15,
          ),
          Container(
            // color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
                  child: TextFormField(
                    controller: _price,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 233, 228, 233),
                      border: OutlineInputBorder(),
                      labelText: 'Price',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ShipingAddress()));
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 10, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Shiping Address",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () async {
              randomString = getRandString(20);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ImagePickerWiget(
                      name: _fname.text,
                      size: SizeShoe,
                      brand: brand,
                      price: _price.text,
                      idSell: randomString,
                    );
                  });
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 233, 231, 231),
              ),
              child: Center(
                child: Text(
                  "Upload Img",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomSheet: buttonSave(),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      // automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0.0,
      backgroundColor: white,
      title: Center(
          child: Text(
        "Add Product Sell",
        style: TextStyle(
          color: Colors.black,
        ),
      )),
    );
  }

  // Widget buttonSave() {
  //   return InkWell(
  //     onTap: () async {
  //       Fluttertoast.showToast(msg: "Update  successfully :) ");
  //     },
  //     child: Container(
  //       color: Color.fromARGB(255, 25, 92, 28),
  //       width: 400,
  //       height: 50,
  //       child: Center(
  //         child: Text(
  //           "Save",
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 17,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
                setState(() {
                  SizeShoe = snapshot.data!.docs[index].get('sizename');
                });

                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: grey,
                )),
                margin: EdgeInsets.only(top: 5),
                // color: blue,
                width: 130,
                height: 80,
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

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  Widget getBrand() {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('brands').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Wrap(
          children: List.generate(snapshot.data!.docs.length, (index) {
            return InkWell(
              onTap: () async {
                setState(() {
                  brand = snapshot.data!.docs[index].get('name');
                });
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: grey,
                )),
                margin: EdgeInsets.only(top: 20, left: 15),
                // color: blue,
                width: 180,
                height: 200,
                child: Card(
                  elevation: 2,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: snapshot.data!.docs[index].get('name'),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15),
                          width: (size.width - 16) / 3,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Container(
                                    width: 250,
                                    height: 140,
                                    child: FadeInDown(
                                      delay: Duration(milliseconds: 300),
                                      child: Container(
                                        width: 250,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: black.withOpacity(0.1),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                snapshot.data!.docs[index]
                                                    .get('imgUrl'),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(1)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index].get('name'),
                                    style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
}

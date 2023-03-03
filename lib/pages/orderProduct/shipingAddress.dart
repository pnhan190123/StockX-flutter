import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/theme/colors.dart';

class ShipingAddress extends StatefulWidget {
  const ShipingAddress({Key? key}) : super(key: key);

  @override
  State<ShipingAddress> createState() => _ShipingAddressState();
}

class _ShipingAddressState extends State<ShipingAddress> {
  TextEditingController _fname = new TextEditingController();
  TextEditingController _country = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _address2 = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zip = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _lname = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  String firstname = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 235, 235),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 15, top: 30),
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    child: Text(
                      "Shiping Address",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Shiping ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 235, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              snapshot.data!.docs[0].get('firstname') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 290),
                            child: Text("First Name"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('firstname'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _fname,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('lastname') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 290),
                            child: Text("Last Name"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('lastname'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _lname,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('country') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 310),
                            child: Text("Country"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('country'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _country,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'Country',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('address') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 310),
                            child: Text("Address"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('address'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _address,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('city') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 340),
                            child: Text("City"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('city'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _city,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'City',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('state') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 220),
                            child: Text("State/Province/Region"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('state'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _state,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'State/Province/Region',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('zip') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 220),
                            child: Text("Zip/PostCode"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('zip'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _zip,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'Zip/PostCode',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              snapshot.data!.docs[0].get('phone') != ""
                  ? Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15, right: 220),
                            child: Text("Phone Number"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 370,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromARGB(255, 202, 200, 202),
                                border: Border.all(
                                  color: Color.fromARGB(255, 116, 113, 113),
                                )),
                            child: Container(
                              margin: EdgeInsets.only(top: 18, left: 10),
                              child: Text(
                                snapshot.data!.docs[0].get('zip'),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 53, 52, 52),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 210),
                            child: Text("Field must not be empty"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 11),
                            child: TextFormField(
                              controller: _phone,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 202, 200, 202),
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 50,
              )
            ],
          );
        },
      ),
      bottomSheet: buttonSave(),
    );
  }

  Widget buttonSave() {
    return InkWell(
      onTap: () async {
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .update({
          'country': _country.text,
          'address': _address.text,
          'address2': _address2.text,
          'city': _city.text,
          'state': _state.text,
          'zip': _zip.text,
          'phone': _phone.text,
        });
      },
      child: Container(
        color: Colors.black,
        width: 400,
        height: 50,
        child: Center(
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}

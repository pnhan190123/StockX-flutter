import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stockx/pages/pageUser/sell/UserSell/sell.dart';
import 'package:stockx/pages/pageUser/sell/buyP2P/sellP2P.dart';

class ImagePickerWiget extends StatefulWidget {
  const ImagePickerWiget(
      {Key? key,
      required this.name,
      required this.size,
      required this.brand,
      required this.price,
      required this.idSell})
      : super(key: key);
  final String name;
  final String size;
  final String price;
  final String brand;
  final String idSell;

  @override
  State<ImagePickerWiget> createState() => _ImagePickerWigetState();
}

class _ImagePickerWigetState extends State<ImagePickerWiget> {
  String? tmp;
  File? _image;
  bool _uploading = false;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(
      () {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<String> uploadFile() async {
      File file = File(_image!.path);
      String imageName =
          'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String? downloadUrl;
      try {
        await FirebaseStorage.instance.ref(imageName).putFile(file);
        downloadUrl =
            await FirebaseStorage.instance.ref(imageName).getDownloadURL();
        if (downloadUrl != null) {
          DateTime now = DateTime.now();
          String convertedDateTime =
              "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";
          User? user = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance.collection('sell').add({
            'date': convertedDateTime,
            'uid': user!.uid,
            'price': widget.price,
            'img': downloadUrl,
            'name': widget.name,
            'size': widget.size,
            'brand': widget.brand,
            'idSell': widget.idSell,
            'buyDone': 0,
          });
          Navigator.push(
            (context),
            MaterialPageRoute(
              builder: (context) => UserSell(),
            ),
          );
          setState(() {
            _image = null;
          });
          Fluttertoast.showToast(msg: "Add product successfully :) ");
        }
      } on FirebaseException catch (e) {
        // String error = e.code;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Cancelled"),
          ),
        );
      }
      return downloadUrl!;
    }

    return Dialog(
      child: Column(
        children: [
          AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              "Upload Image",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    if (_image != null)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState() {
                              _image = null;
                            }
                          },
                        ),
                      ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        child: _image == null
                            ? Icon(
                                CupertinoIcons.photo_on_rectangle,
                                color: Colors.grey,
                              )
                            : Image.file(_image!),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (_image != null)
                  Row(
                    children: [
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            setState(() {
                              _uploading = true;
                              uploadFile().then((url) {
                                if (url != null) {
                                  setState(() {
                                    _uploading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Upload image  successfully :) ");
                                } else {}
                              });
                            });
                          },
                          child: Text(
                            'Add Product',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            color: Colors.red,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: NeumorphicButton(
                        onPressed: getImage,
                        style: NeumorphicStyle(
                            color: Theme.of(context).primaryColor),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (_uploading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

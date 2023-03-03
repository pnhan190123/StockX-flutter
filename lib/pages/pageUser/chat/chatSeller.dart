import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/theme/colors.dart';

class Chat extends StatefulWidget {
  const Chat({required this.idRoom, required this.uidSeller, Key? key})
      : super(key: key);
  final String idRoom;
  final String uidSeller;
  @override
  State<Chat> createState() => _ChatuState();
}

class _ChatuState extends State<Chat> {
  TextEditingController _value = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(),
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 240, 235, 235),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _value,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: "Message to Seller",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance.collection('chat').add(
                    {
                      'uidSender': user?.uid,
                      'content': _value.text,
                      'createAt': Timestamp.now(),
                      'idChatroom': widget.idRoom,
                      'uidRevicer': widget.uidSeller,
                    },
                  );

                  // final QuerySnapshot result = await FirebaseFirestore.instance
                  //     .collection('listChat')
                  //     .where('uidRevicer', isEqualTo: widget.uidSeller)
                  //     .where('uidSender', isEqualTo: user?.uid)
                  //     .limit(1)
                  //     .get();
                  // final List<DocumentSnapshot> documents = result.docs;
                  // if (documents.length > 0) {
                  //   print("TRUNG");
                  // } else {
                  //   await FirebaseFirestore.instance.collection('listChat').add(
                  //     {
                  //       'uidSender': user?.uid,
                  //       'createAt': Timestamp.now(),
                  //       'idChatroom': widget.idRoom,
                  //       'uidRevicer': widget.uidSeller,
                  //     },
                  //   );
                  // }

                  _value.clear();
                },
                child: Text(
                  "Gửi",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .where('idChatroom', isEqualTo: widget.idRoom)
          // .where('uidRevicer', isEqualTo: widget.uidSeller)
          .orderBy('createAt', descending: false)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, indexMessage) {
              if (snapshot.data!.docs[indexMessage].get('uidSender') ==
                  user?.uid) {
                return Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Text(
                      snapshot.data!.docs[indexMessage].get('content'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.data!.docs[indexMessage].get('uidSender') ==
                  widget.uidSeller) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Text(
                      snapshot.data!.docs[indexMessage].get('content'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }
              return Text("");
            },
          );
        } else {
          return Container(
            child: Text(""),
          );
        }
      },
    );
  }

  AppBar getAppbar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      backgroundColor: white,
      title: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: widget.uidSeller)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: EdgeInsets.only(
              left: 60,
            ),
            child: Text(
              snapshot.data!.docs[0].get('username'),
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          );
        },
      ),
    );
  }
}

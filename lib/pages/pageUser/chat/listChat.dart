import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stockx/pages/pageUser/chat/chatSeller.dart';

class ListChat extends StatefulWidget {
  const ListChat({Key? key}) : super(key: key);

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isNotEqualTo: user?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                color: Color.fromARGB(255, 233, 233, 233),
                child: ListView(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            snapshot.data!.docs[index].get('username'),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Chat(
                                    idRoom: "\$~!@~\$!@!\$!~@~",
                                    uidSeller:
                                        snapshot.data!.docs[index].get('uid'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ));
          }),
    );
  }

  AppBar getAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 36, 83, 38),
      title: Container(
        child: Text("Chat List"),
      ),
    );
  }
}

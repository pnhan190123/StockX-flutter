import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SellP2P extends StatefulWidget {
  const SellP2P({Key? key}) : super(key: key);

  @override
  State<SellP2P> createState() => _SellP2PState();
}

class _SellP2PState extends State<SellP2P> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "Sell",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

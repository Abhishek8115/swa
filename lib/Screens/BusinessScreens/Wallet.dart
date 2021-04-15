import 'package:flutter/material.dart';

class Wallet_Business extends StatefulWidget {
  @override
  _Wallet_BusinessState createState() => _Wallet_BusinessState();
}

class _Wallet_BusinessState extends State<Wallet_Business> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Wallet",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

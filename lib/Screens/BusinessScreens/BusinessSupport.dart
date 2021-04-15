import 'package:flutter/material.dart';

class Business_Support extends StatefulWidget {
  @override
  _Business_SupportState createState() => _Business_SupportState();
}

class _Business_SupportState extends State<Business_Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Support",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

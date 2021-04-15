import 'package:flutter/material.dart';
import 'package:swap/SplashScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Swap',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Splash(),
    );
  }
}

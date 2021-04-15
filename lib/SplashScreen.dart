import 'package:flutter/material.dart';
import 'package:swap/Screens/loginScreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2) , (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/food.png" , height: MediaQuery.of(context).size.width/2, width: MediaQuery.of(context).size.width/2,),
      ),
    );
  }
}

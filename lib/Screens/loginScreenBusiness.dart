import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swap/Screens/landing_page.dart';
import 'package:swap/Screens/signup.dart';
import 'package:swap/Screens/Check.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert' as JSON;
import 'package:toast/toast.dart';

class LoginPageBusiness extends StatefulWidget {
  @override
  _LoginPageBusinessState createState() => new _LoginPageBusinessState();
}

class _LoginPageBusinessState extends State<LoginPageBusiness> with TickerProviderStateMixin{

  bool _isLoggedIn = true;
  Map userProfile;
  var _razorpay = Razorpay();
  AnimationController _animationController;
  var data;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final facebookLogin = FacebookLogin();
  _loginwithFB()async{
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  _logout(){
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future<http.Response> getData(String number, String password) async {
    final response = await http.post('https://foodswap-backend.herokuapp.com/login',
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(
          {"contactNumber": "1234567890", 
          "password": "password",
          "location":{
            "coordinates":[ 41.40338, 2.17403]
            }
          }
        )
      );
    print('response: ${response.statusCode}');
  
    if (response.statusCode == 200) {
      print('Success');
      return response;
    } else if (response.statusCode == 400) {
      print(response.statusCode);
      return response;
    }
    return response;
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_razorpay.clear(); // Removes all listeners
    _animationController.dispose();
  }
  var options;
  @override
  void initState() {
    super.initState();
    
    _animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _animationController.repeat();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 50,),
          Center(
            child: Container(
              width: 150,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffFFFFFF), width: 10),
                image: DecorationImage(
                  image: AssetImage("assets/food.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0.0, 0.0),
            child: Center(
              child: Text('Log in', style: TextStyle(fontSize: 30.0, color: Colors.black , fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
         
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Theme(
              data: ThemeData(
                primaryColor: Color(0xffFFFFFF),
                primaryColorDark: Color(0xffFFFFFF),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                    controller: username,
                    cursorColor: Color(0xff90E5BF),
                    decoration: InputDecoration(
                        filled: true,
                        hintText: "Mobile number",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            child: Text(
                              " ",
                              style: TextStyle(
                                color: Color(0xff90E5BF),
                              ),
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Color(0xffFFFFFF),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(100.0),
                          ),
                        ))),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Theme(
              data: ThemeData(
                primaryColor: Color(0xffFFFFFF),
                primaryColorDark: Color(0xffFFFFFF),
              ),
              child: TextField(
                  obscureText: true,
                  controller: password,
                  cursorColor: Color(0xff90E5BF),
                  decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Password",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: Text(
                            "Forgot?",
                            style: TextStyle(color: Color(0xff90E5BF)),
                          ),
                        ),
                      ),
                      fillColor: Color(0xffFFFFFF),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(100.0),
                        ),
                      ))),
            ),
          ),
          SizedBox(height: 40.0),
          InkWell(
            onTap: () async {
              if(username.text.isEmpty || password.text.isEmpty)
              {
                return(
                  Toast.show("Please Enter Valid Details", context,
                    duration: 1,
                    gravity: 0,
                    backgroundColor: Colors.indigo[200])
                );
              }
              print("hello");
              print("number: ${username.text}");
              print("password: ${password.text}");
              http.Response result = await getData(username.text.trim(), password.text.trim());
              print(result.body);
              return;
              showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: AlertDialog(
                    title:Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.indigo, 
                          valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                          strokeWidth: 6.0,
                        ),
                        SizedBox(width: size.width*0.1),
                        Text("Loading")
                      ]
                    )
                  ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 300),
              barrierDismissible: false,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {});
              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingPage()), (Route<dynamic> route) => false);

              // print("hello");
              // print("email: ${username.text}");
              // print("password: ${password.text}");
              // String result = await getData(username.text, password.text);
              // if (result.contains("success!")) {
              //
               Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => LandingPage()), (Route<dynamic> route) => false);
              // }
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Color(0xff62319E),
                    borderRadius: BorderRadius.circular(100.0)),
                child: Center(
                  child: Text('Log in',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
                 
          
           
                           

        ],
      ),
    );
  }
}

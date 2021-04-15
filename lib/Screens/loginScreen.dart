import 'dart:convert';
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
import 'loginScreenBusiness.dart';
import 'loginScreenNGO.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:convert/convert.dart';
import 'resetPassword.dart';
import 'package:swap/Screens/UserScreens/UserDashboard.dart';
import 'package:swap/Screens/BusinessScreens/BusinessDashboard.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  static String token;
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
    final response = await http.post('https://food2swap.herokuapp.com/api/auth/login_with_username',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "username": number, 
            "password": password,
          }
        )
      );
    //print('response: ${response.statusCode}');
  
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
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // options = {
    //   'key': 'rzp_test_1ns0ChyiK9yBT1',
    //   'amount': 50000, //in the smallest currency sub-unit.
    //   'name': 'Laxman private limited',
    //   'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    //   'description': 'Food Swap application for android as well as iOS',
    //   'timeout': 60, // in seconds
    //   'prefill': {
    //     'contact': '9123456789',
    //     'email': 'gaurav.kumar@example.com'
    //   }
    // };
    
    _animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _animationController.repeat();
  }
  
// Future payRazor()async
// {
//   try{
//     _razorpay.open(options);
//   }catch(e){
//     debugPrint(e);
//   }
//   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
// }
  // try{
  //   _razorpay.open(options);
  // }catch(e){
  //   debugPrint(e);
  // }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//   // Do something when payment succeeds
// }

// void _handlePaymentError(PaymentFailureResponse response) {
//   // Do something when payment fails
// }

// void _handleExternalWallet(ExternalWalletResponse response) {
//   // Do something when an external wallet is selected
// }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
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
          // Center(
          //   child: Container(
          //     width: 150,
          //     height: 170,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color: Color(0xffFFFFFF), width: 10),
          //       image: DecorationImage(
          //         image: AssetImage("assets/man.png"),
          //           fit: BoxFit.cover),
          //     ),
          //   ),
          // ),
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
                        hintText: "email or number",
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
                      hintText: "password",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>ResetPassword()));
                          },
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
              Map<String , dynamic> loginDetails = jsonDecode(result.body);
              print(loginDetails['data']['token']);

              Directory directory = await getApplicationDocumentsDirectory();
              File file = File('${directory.path}/token.txt');
              await file.writeAsString(loginDetails['data']['token']);
              File file2 = File('${directory.path}/userId.txt');
              await file2.writeAsString(loginDetails['data']['userId']);
              token = loginDetails['token'];
              showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: AlertDialog(
                    title:Row(
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
              pageBuilder: (context, animation1, animation2) {}
              );
              //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LandingPage()), (Route<dynamic> route) => false);

              // print("hello");
              // print("email: ${username.text}");
              // print("password: ${password.text}");
              // String result = await getData(username.text, password.text);
              // if (result.contains("success!")) {
              if(loginDetails['type'] == 'success'){
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => BusinessDashboard()), (Route<dynamic> route) => false);
                loginDetails = null;
              }
              else{
                loginDetails = null;
                return(
                  Toast.show("Please Enter Valid Details", context,
                    duration: 1,
                    gravity: 0,
                    backgroundColor: Colors.indigo[200])
                );
              }
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
          SizedBox(height: 20.0),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width*0.2),
                //   child: ButtonTheme(  
                //     buttonColor: Color(0xff62319E),                  
                //     height: size.height*0.05,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                //     child: RaisedButton(
                //       child: Text("Login as Business Owner", style :TextStyle(color: Colors.white)),
                //       onPressed: (){
                //         Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => LoginPageBusiness()));
                //         print("Do nothing");}
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10.0),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width*0.2),
                //   child: ButtonTheme(  
                //     buttonColor: Color(0xff62319E),                  
                //     height: size.height*0.05,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                //     child: RaisedButton(
                //       child: Text("Login as NGO", style :TextStyle(color: Colors.white)),
                //       onPressed: (){
                //         Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => LoginPageNGO()));
                //         print("Do nothing");}
                //     ),
                //   ),
                // ),   
          //SizedBox(height: 15.0),
          Center(
            child: InkWell(
                onTap: ()async{

                  // debugPrint("Function called");
                  //  Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (context) => CheckRazor(),
                  //   ),
                  //   (Route<dynamic> route) => false);
                  // return WebView(
                  //   initialUrl: "https://medium.com/@naveenyadav4116/razorpay-integration-with-flutter-df9ecb8a810a",
                  //   //onWebViewCreated:await payRazor(),
                  // );
                  // payRazor();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));


                },
                child: Text("SignUp", style: TextStyle(fontSize: size.height*0.025, fontWeight: FontWeight.w500))),
          ),
            SizedBox(height: 20.0),
            InkWell(
                onTap: ()async{
                
                 await _loginwithFB();
                 showGeneralDialog(
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 700),
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Image.network(userProfile["picture"]["data"]["url"], height: 50.0, width: 50.0,),
                      Text(userProfile["name"]),
                      OutlineButton( child: Text("Logout"), onPressed: (){
                        _logout();
                      },)
                    ],
                  );
                  },
                  transitionBuilder: (_, anim, __, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
                      child: child,
                    );
                  },
                );

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Login using facebook"),
                    SizedBox(
                      height: size.height*0.05,
                      width: size.width*0.1,
                      child: Image.asset("assets/facebook.png"))
                  ],
                )),
                           

        ],
      ),
    );
  }
}

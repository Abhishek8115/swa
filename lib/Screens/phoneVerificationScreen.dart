import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swap/Screens/BusinessScreens/BusinessDashboard.dart';
import 'package:swap/Screens/UserScreens/UserDashboard.dart';
import 'package:swap/global.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swap/Screens/Donate/DonateDashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'signup.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController pin = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  String currentText = "";

  int accountType = 1;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xffF5F5F2),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Otp Verification',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 30.0, 9.0, 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Enter the 4-digit code sent to your phone number',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 2,
                      fieldHeight: 60,
                      fieldWidth: 50,
                      selectedColor: Colors.grey[700],
                      selectedFillColor: Color(0xff62319E),
                      inactiveColor: Colors.red,
                      inactiveFillColor: Colors.white,
                      activeColor: Colors.green,
                      activeFillColor: Color(0xff62319E),
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: pin,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    appContext: context,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn't recieve code? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF818181),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Resend the code to the user");
                      },
                      child: Text(
                        "Request again",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Spacer(),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () async{
                          // final response =
                          // await http.post('https://foodswap-backend.herokuapp.com/verify',
                          //     headers: {
                          //       "Content-Type": "application/json"
                          //       },
                          //     body: jsonEncode({
                          //       "otp":"1234",	
                          //       "userId":userId,
                          //       // "location":{
                          //       //     "coordinates":[41.40338, 2.17403]
                          //       //   }                                
                          //     }));
                          //     Map<String , dynamic> userDetails= jsonDecode(response.body);
                          //     print(userDetails['token']);
                          if (selectedIndex == 0) 
                          {
                            Directory directory = await getApplicationDocumentsDirectory(); 
                            File file2 = File('${directory.path}/userId.txt');
                            String userId = await file2.readAsString();
                            print(userId);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => BusinessDashboard()));
                          } else if(selectedIndex == 1)
                          {
                            Directory directory = await getApplicationDocumentsDirectory(); 
                            File file2 = File('${directory.path}/userId.txt');
                            String userId = await file2.readAsString();
                            print(userId);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => UserDashboard()));
                          }
                          else if(selectedIndex == 2){
                            Navigator.pushReplacement(
                              context, 
                              CupertinoPageRoute(builder: (context)=>DonateDashboard())
                              );
                          }
                        },
                        color: Color(0xff62319E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Color(0xff62319E))),
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

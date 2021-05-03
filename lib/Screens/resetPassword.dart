import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:swap/global.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool passwordSet = false;
  bool numberfetch = false;
  bool verifyNumber = false;
  String otpverifier;
  String userId, token;
  TextEditingController number = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController pin = TextEditingController();
  StreamController<ErrorAnimationType> errorController;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    // TODO: implement initState
    super.initState();
    passwordSet = false;
    numberfetch = false;
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }
  void verifyUserNumber(String userId)async{
    print("reached at dialog box");
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
            title:Column(
              children:<Widget>[
                SizedBox(
                  height: 200,
                  child: Center(
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
                            //currentText = value;
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
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: MediaQuery.of(context).size.width*0.2),
                child: ButtonTheme(  
                  buttonColor: Color(0xff62319E),                  
                  height: MediaQuery.of(context).size.height*0.05,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                    child: Text("Verify OTP", style :TextStyle(color: Colors.white)),
                    onPressed: ()async{
                      //Navigator.pop(context);
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
                                  //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                                  strokeWidth: 6.0,
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.1),
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
                      print(pin.text.trim());
                      http.Response result = await http.post("$path/auth/verify_phone_otp",
                        headers: {"Content-Type":"application/json"},
                        body: jsonEncode({
                          "otp":pin.text.trim(),
                          "userId":userId
                        })
                        );  
                      Navigator.pop(context);   
                      Navigator.pop(context); 
                      Map<String, dynamic> ans= jsonDecode(result.body);
                      print("printing result : $ans" );
                      print(ans['type']);
                      otpverifier =  ans['type'];
                      print(otpverifier);
                      setState(() {
                        
                      });
                      if(ans['type'] == "error")
                      {     
                        print("otp mismatch"); 
                        Navigator.pop(context); 
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
                                  Icon(Icons.error, size: MediaQuery.of(context).size.width*0.05),
                                  SizedBox(width: MediaQuery.of(context).size.width*0.1),
                                  Text("Incorrect otp")
                                ]
                              )
                            ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {}
                        );                
                        
                      }
                      else if(ans['type'] == "success"){
                        //Navigator.pop(context);
                        showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                              title:Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Theme(
                                    data: ThemeData(
                                      primaryColor: Colors.grey,
                                      primaryColorDark: Color(0xffFFFFFF),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.numberWithOptions(),
                                          controller: newPassword,
                                          cursorColor: Color(0xff90E5BF),
                                          decoration: InputDecoration(
                                          filled: true,
                                          hintText: "new password",
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
                                          fillColor: Colors.grey[50],
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: const BorderRadius.all(
                                              const Radius.circular(100.0),
                                            ),
                                          )
                                        )
                                      ),
                                    ),
                                  ),
                            ),
                            // SizedBox(height: MediaQuery.of(context).size.height*0.04),
                            //     Padding(
                            //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            //       child: Theme(
                            //         data: ThemeData(
                            //           primaryColor: Colors.grey,
                            //           primaryColorDark: Color(0xffFFFFFF),
                            //         ),
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             color: Colors.grey,
                            //             borderRadius: BorderRadius.circular(32),
                            //           ),
                            //           child: TextField(
                            //             keyboardType: TextInputType.numberWithOptions(),
                            //               controller: oldPassword,
                            //               cursorColor: Color(0xff90E5BF),
                            //               decoration: InputDecoration(
                            //               filled: true,
                            //               hintText: "old password",
                            //               suffixIcon: Padding(
                            //                 padding: const EdgeInsets.all(20.0),
                            //                 child: GestureDetector(
                            //                   child: Text(
                            //                     " ",
                            //                     style: TextStyle(
                            //                       color: Color(0xff90E5BF),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            //               fillColor: Colors.grey[50],
                            //               border: OutlineInputBorder(
                            //                 borderSide: BorderSide.none,
                            //                 borderRadius: const BorderRadius.all(
                            //                   const Radius.circular(100.0),
                            //                 ),
                            //               )
                            //             )
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.05,),          
                                Center(
                                  child: ButtonTheme(  
                                    buttonColor: Color(0xff62319E),                  
                                    height: MediaQuery.of(context).size.height*0.05,
                                    minWidth: MediaQuery.of(context).size.width*3,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    child: RaisedButton(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text("Change ", 
                                            style :TextStyle(
                                              color: Colors.white, 
                                              fontWeight: FontWeight.w300  
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text("password", 
                                            style :TextStyle(
                                              color: Colors.white, 
                                              fontWeight: FontWeight.w300  
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onPressed: ()async{
                                        if(newPassword.text.isEmpty )
                                        {
                                          return(
                                          Toast.show("Please Enter Valid Details", context,
                                            duration: 1,
                                            gravity: 0,
                                            backgroundColor: Colors.indigo[200])
                                        );
                                        }
                                        else{
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
                                                    //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                                                    strokeWidth: 6.0,
                                                  ),
                                                  SizedBox(width: MediaQuery.of(context).size.width*0.1),
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
                                        http.Response response = await http.post(
                                          'https://food2swap.herokuapp.com/api/auth/reset_password',
                                          headers: {"Content-Type": "application/json"},
                                          body: jsonEncode({
                                            "newPassword": newPassword.text.trim(),
                                            "userId": userId
                                          }
                                        )
                                        );
                                        Map<String, dynamic> details= jsonDecode(response.body);
                                        print(details);
                                        Navigator.pop(context);
                                        Navigator.pop(context);                                       
                                        setState(() {
                                          passwordSet = true;
                                        });
                                      // Navigator.push(context,
                                      // MaterialPageRoute(builder: (context) => LoginPageNGO()));
                                        //print("Do nothing");}
                                        }
                                      }
                                    ),
                                  ),
                                ), 
                              ],
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
                      }
                       
                    }
                  ),
                ),
              )
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
      print("otVerifier Value : $otpverifier");
      //return otpverifier;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar:AppBar(
        backgroundColor: Colors.purple,
        title: Text("Reset Password")
      ),
      body: passwordSet?
      Center(
        child:Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.3,),
            Text("Password Changed", style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).size.height*0.035)),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Icon(Icons.check_circle_outlined, color: Colors.greenAccent[400], size: MediaQuery.of(context).size.height*0.1)
          ]
        )
      ):
      Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.1),
           Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Theme(
              data: ThemeData(
                primaryColor: Colors.grey,
                primaryColorDark: Color(0xffFFFFFF),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                    controller: number,
                    cursorColor: Color(0xff90E5BF),
                    decoration: InputDecoration(
                    filled: true,
                    hintText: "mobile number",
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
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(100.0),
                      ),
                    )
                  )
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.04),
          //  numberfetch?
          //  Column(
          //    children: <Widget>[
          //      Padding(
          //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //       child: Theme(
          //         data: ThemeData(
          //           primaryColor: Colors.grey,
          //           primaryColorDark: Color(0xffFFFFFF),
          //         ),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Colors.grey,
          //             borderRadius: BorderRadius.circular(32),
          //           ),
          //           child: TextField(
          //             keyboardType: TextInputType.numberWithOptions(),
          //               controller: newPassword,
          //               cursorColor: Color(0xff90E5BF),
          //               decoration: InputDecoration(
          //               filled: true,
          //               hintText: "new password",
          //               suffixIcon: Padding(
          //                 padding: const EdgeInsets.all(20.0),
          //                 child: GestureDetector(
          //                   child: Text(
          //                     " ",
          //                     style: TextStyle(
          //                       color: Color(0xff90E5BF),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //               fillColor: Colors.grey[50],
          //               border: OutlineInputBorder(
          //                 borderSide: BorderSide.none,
          //                 borderRadius: const BorderRadius.all(
          //                   const Radius.circular(100.0),
          //                 ),
          //               )
          //             )
          //           ),
          //         ),
          //       ),
          // ),
          // SizedBox(height: MediaQuery.of(context).size.height*0.04),
          //      Padding(
          //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //       child: Theme(
          //         data: ThemeData(
          //           primaryColor: Colors.grey,
          //           primaryColorDark: Color(0xffFFFFFF),
          //         ),
          //         child: Container(
          //           decoration: BoxDecoration(
          //             color: Colors.grey,
          //             borderRadius: BorderRadius.circular(32),
          //           ),
          //           child: TextField(
          //             keyboardType: TextInputType.numberWithOptions(),
          //               controller: oldPassword,
          //               cursorColor: Color(0xff90E5BF),
          //               decoration: InputDecoration(
          //               filled: true,
          //               hintText: "old password",
          //               suffixIcon: Padding(
          //                 padding: const EdgeInsets.all(20.0),
          //                 child: GestureDetector(
          //                   child: Text(
          //                     " ",
          //                     style: TextStyle(
          //                       color: Color(0xff90E5BF),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //               fillColor: Colors.grey[50],
          //               border: OutlineInputBorder(
          //                 borderSide: BorderSide.none,
          //                 borderRadius: const BorderRadius.all(
          //                   const Radius.circular(100.0),
          //                 ),
          //               )
          //             )
          //           ),
          //         ),
          //       ),
          //     ),
          //    ],
          //  ):
           Column(
             children: <Widget>[
               Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: MediaQuery.of(context).size.width*0.2),
                child: ButtonTheme(  
                  buttonColor: Color(0xff62319E),                  
                  height: MediaQuery.of(context).size.height*0.05,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: RaisedButton(
                    child: Text("Verify number", style :TextStyle(color: Colors.white)),
                    onPressed: ()async{
                      if(number.text.isEmpty)
                      {
                        return(
                        Toast.show("Please Enter Valid Details", context,
                          duration: 1,
                          gravity: 0,
                          backgroundColor: Colors.indigo[200])
                      );
                      }
                      
                      print("${number.text.trim().toString()}");
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
                                  //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                                  strokeWidth: 6.0,
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width*0.1),
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
                      http.Response response =await http.post('$path/auth/login_with_phone_otp',
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode(
                          {
                            "phone": number.text.trim()
                          }
                        )
                      );
                      Navigator.pop(context);
                      Map<String, dynamic> d= jsonDecode(response.body);
                      print(d);
                      String type = d['type'];  
                      print(type);                
                      
                      //print("Printing user Id : $userId");
                      if(d['type'] == "error"){
                        //Navigator.pop(context);
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
                                        Icon(Icons.error, size: MediaQuery.of(context).size.width*0.05),
                                        SizedBox(width: MediaQuery.of(context).size.width*0.1),
                                        Text("Number not found")
                                      ]
                                    )
                                  ),
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 300),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder: (context, animation1, animation2) {}
                              );
                              setState(() {
                      });
                      }
                      else{
                        userId = d['data']['userId'];
                        token = d['data']['token'];
                        print("calling verify otp");
                        verifyUserNumber(userId);
                        //print(res);
                        if(otpverifier == "error")
                        {
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
                                    Icon(Icons.error, size: MediaQuery.of(context).size.width*0.05),
                                    SizedBox(width: MediaQuery.of(context).size.width*0.1),
                                    Text("Incorrect otp")
                                  ]
                                )
                              ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 300),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {}
                          ); 
                          print("reached  here");
                          
                        }
                        else if(otpverifier == "success"){
                          print("otp matched");
                          //Navigator.pop(context);
                          //print(res);
                          numberfetch = true;
                          setState(() {
                            
                          });
                        }
                        //Navigator.pop(context);
                        setState(() {                      
                        });
                      }
                      print(response.body);
                      
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => LoginPageNGO()));
                      print("Do nothing");}
                  ),
                ),
          ),
             ],
           ), 
          
        ],
      ),
    );
  }
}

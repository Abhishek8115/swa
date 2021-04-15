import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:swap/global.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:pin_code_fields/pin_code_fields.dart';
class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool passwordSet = false;
  bool numberfetch = false;
  String userId;
  TextEditingController number = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController pin = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordSet = false;
    numberfetch = false;
  }
  Future<String> verifyUserNumber(String userId)async{
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
                    //errorAnimationController: errorController,
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
                      http.Response result = await http.post("$path/auth/verify_phone_otp",
                        headers: {"Content-Type":"application/json"},
                        body: jsonEncode({
                          "otp":pin.text.trim(),
                          "userId":userId
                        })
                        );        
                      Map<String, dynamic> d= jsonDecode(result.body);
                      if(d['type'] == "error")
                      {                       
                        return "notFound";
                      }
                      return "found";                      
                      setState(() {
                        //passwordSet = true;
                      });
                      print("Do nothing");}
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
           numberfetch?
           Column(
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
          SizedBox(height: MediaQuery.of(context).size.height*0.04),
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
                        controller: oldPassword,
                        cursorColor: Color(0xff90E5BF),
                        decoration: InputDecoration(
                        filled: true,
                        hintText: "old password",
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
             ],
           ):
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
                  http.Response response =await http.post('$path/auth/login_with_phone_otp',
                    headers: {"Content-Type": "application/json"},
                    body: jsonEncode(
                      {
                        "phone": number.text.trim()
                      }
                    )
                  );
                  Map<String, dynamic> d= jsonDecode(response.body);
                  userId = d['data']['userId'];
                  
                  String res = await verifyUserNumber(userId);
                  if(res == "notFound"){
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
                    Navigator.pop(context);
                    numberfetch = true;
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
          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
          numberfetch?
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: MediaQuery.of(context).size.width*0.2),
            child: ButtonTheme(  
              buttonColor: Color(0xff62319E),                  
              height: MediaQuery.of(context).size.height*0.05,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: RaisedButton(
                child: Text("Change password", style :TextStyle(color: Colors.white)),
                onPressed: ()async{
                  // http.Response response = await http.patch(
                  //   'https://food2swap.herokuapp.com/api/auth/6072a27393b8790015b04e2c/change_password',
                  //   body: {
                  //     "newPassword": "nyapassword",
                  //     "oldPassword": "puranaPassoword"
                  //   }
                  // );
                  setState(() {
                    passwordSet = true;
                  });
                // Navigator.push(context,
                // MaterialPageRoute(builder: (context) => LoginPageNGO()));
                  print("Do nothing");}
              ),
            ),
          ):
          Text(" "), 
        ],
      ),
    );
  }
}

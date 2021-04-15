import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap/Screens/BusinessScreens/BusinessDashboard.dart';
import 'package:swap/Screens/UserScreens/UserDashboard.dart';
import 'package:swap/Screens/landing_page.dart';

class UserSignUpDetails extends StatefulWidget {
  @override
  _UserSignUpDetailsState createState() => _UserSignUpDetailsState();
}

class _UserSignUpDetailsState extends State<UserSignUpDetails> {
  int selectedIndex = -1;
  bool error = false;

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xffF5F5F2),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Enter Your Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(9.0, 20.0, 9.0, 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Container(
              //     alignment: Alignment.bottomRight,
              //     width: MediaQuery.of(context).size.width * 0.9,
              //     height: MediaQuery.of(context).size.height * 0.25,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         color: Colors.grey[600]),
              //     child: Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: IconButton(
              //         onPressed: () {
              //           print('tapped');
              //         },
              //         icon: Icon(
              //           Icons.create,
              //           size: 40,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child:
                        Text('Account Type', style: TextStyle(fontSize: 20))),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(2, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(selectedIndex == index
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off),
                          SizedBox(
                            width: 10,
                          ),
                          Text(index == 0 ? 'Business Owner' : 'Personal')
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xff62319E))),
                child: TextFormField(
                    validator: (val) {
                      setState(() {
                        val.isEmpty ? error = true : error = false;
                      });
                      return null;
                    },
                    onTap: () {
                      setState(() {
                        error = false;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText:
                          error ? "Description can't be empty" : "Description",
                      errorMaxLines: 3,
                      hintStyle: TextStyle(
                          color: error
                              ? Colors.deepOrangeAccent
                              : Color(0xff62319E)),
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        if (selectedIndex == 0) {
                          //Business

                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => BusinessDashboard()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => UserDashboard()));
                        }

                        // Navigator.pushReplacement(
                        //     context,
                        //     CupertinoPageRoute(
                        //         builder: (context) => LandingPage()));
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
            ],
          ),
        ),
      ),
    );
  }
}

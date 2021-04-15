import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap/Screens/ChatScreen.dart';
import 'package:swap/SplashScreen.dart';

import 'bartering.dart';
import 'donate.dart';
import 'fresh_sale.dart';
import 'friendly.dart';

class LandingPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
              child: ListView(
                children: [
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      CircleAvatar(
                        radius: 30.0,
                        //backgroundImage: Image.asset('user.png'),
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/user.png'),
                      ),

                      Column(
                        children: [
                          Text("Name" , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                          Text("Business Owner" , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal , fontSize: 16),)
                        ],
                      )


                    ],
                  ),

                  SizedBox(height: 5,),

                  InkWell(
                    onTap: (){


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/home.png", fit: BoxFit.cover),
                        ),
                        title: Text("Home"),
                      ),
                    ),
                  ),



                  ExpansionTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/category.png", fit: BoxFit.cover),
                        ),
                        title: Text("Category"),
                      ),
                    ),
                    children: <Widget>[Text("children 1"), Text("children 2")],
                  ),


                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                        ),
                        title: Text("My Posts"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/chat.png", fit: BoxFit.cover),
                        ),
                        title: Text("Chat"),
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){

                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/user.png", fit: BoxFit.cover),
                        ),
                        title: Text("Dashboard"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Parking_Lot_Screen()));


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/bell.png", fit: BoxFit.cover),
                        ),
                        title: Text("Notifications"),
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/support.png", fit: BoxFit.cover),
                        ),
                        title: Text("Support"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/faq.png", fit: BoxFit.cover),
                        ),
                        title: Text("FAQ"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){


                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/wallet.png", fit: BoxFit.cover),
                        ),
                        title: Text("My Wallet"),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Splash()), (Route<dynamic> route) => false);



                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Image.asset("assets/logout2.png", fit: BoxFit.cover),
                        ),
                        title: Text("Logout"),
                      ),
                    ),
                  ),

                  SizedBox(height: 20,)

                ],
              )),

          backgroundColor: Color(0xffE9E9E9),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: InkWell(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            title: Center(
                child: Text("Menu", style: TextStyle(color: Colors.black))),
            actions: [
              IconButton(
                onPressed: () {
        
                },
                icon: Icon(Icons.search),
                tooltip: 'Search',
                color: Colors.black,
                iconSize: 30,
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 40,
                  color: Color(0xffE9E9E9),
                  child: TabBar(
                      unselectedLabelColor: Color(0xff656565),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: Color(0xff62319E)),
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Flash Sale",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Friendly",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Bartering",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Donate",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Expanded(
                flex: 4,
                child: TabBarView(
                  // Tab Bar View
                  physics: BouncingScrollPhysics(),

                  children: <Widget>[
                    FreshSale(),
                    Friendly(),
                    Bartering(),
                    Donate()
                  ],
                ),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Color(0xff62319E),
          //   foregroundColor: Color(0xff62319E),
          //   child: Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //
          //     // Navigator.pushReplacement(
          //     //   context,
          //     //   CupertinoPageRoute(
          //     //     builder: (context) {
          //     //       return GetPostImage();
          //     //     },
          //     //   ),
          //     // );
          //
          //   },
          // ),
        ));
  }
}

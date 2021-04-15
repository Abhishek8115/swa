import 'package:flutter/material.dart';
import 'package:swap/Screens/ChatScreen.dart';
import 'package:swap/Screens/Donate/DonatedItems.dart';
import 'package:swap/Screens/UserScreens/AddItemsDonate.dart';
import 'package:swap/Screens/UserScreens/AddItemsFlashSale.dart';
import 'package:swap/Screens/UserScreens/AddItemsFriendly.dart';
import 'package:swap/Screens/UserScreens/MyPost.dart';
import 'package:swap/Screens/bartering.dart';
import 'package:swap/Screens/donate.dart';
import 'package:swap/Screens/fresh_sale.dart';
import 'package:swap/Screens/friendly.dart';
import 'package:swap/SplashScreen.dart';
import 'package:swap/Screens/UserScreens/EditProfile.dart';

class DonateDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<DonateDashboard> {


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
                          Text("Organisation " , style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 18),),
                          SizedBox(height:10),
                          Text("Leader" , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal , fontSize: 16),)
                        ],
                      )


                    ],
                  ),

                  SizedBox(height: 10,),

                  // InkWell(
                  //   onTap: (){


                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 10, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/home.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("Home"),
                  //     ),
                  //   ),
                  // ),



                  


                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("Service Rules"),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("LIcence agreement"),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("Privacy Policy"),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>EditProfile()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          child: Icon(Icons.mode_edit),
                        ),
                        title: Text("Edit Profile"),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("My Posts"),
                  //     ),
                  //   ),
                  // ),
                  
                  // ListTile(
                  //   onTap: (){
                  //     //Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPost()));
                  //     showModalBottomSheet(
                  //       context: context,
                  //       builder: (BuildContext bc) {
                  //         return SafeArea(
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               //borderRadius: BorderRadius.circular(100),
                  //               shape: BoxShape.circle
                  //             ),
                  //             child: new Wrap(
                  //               children: <Widget>[
                  //                 new ListTile(
                  //                   selectedTileColor: Colors.purple[100],
                  //                   focusColor: Colors.purple[100],
                  //                     //leading: new Icon(Icons.giv),
                  //                     title: new Text('Donate', style : TextStyle(fontWeight: FontWeight.w600)),
                  //                     onTap: () {
                  //                       //_imgFromGallery();
                  //                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsDonate()));
                  //                     }),
                  //                   new ListTile(
                  //                   //leading: new Icon(Icons.),
                  //                   title: new Text('Friendly', style : TextStyle(fontWeight: FontWeight.w600)),
                  //                   onTap: () {
                  //                     //_imgFromGallery();
                  //                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFriendly()));
                  //                   }),
                  //                 new ListTile(
                  //                   //leading: new Icon(Icons.photo_camera),
                  //                   title: new Text('Flash Sale', style : TextStyle(fontWeight: FontWeight.w600)),
                  //                   onTap: () {
                  //                     //_imgFromCamera();
                  //                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFlashSale()));
                  //                   },
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //   );
                  //   },
                  //   title: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, 0, 10,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Icon(Icons.add_circle_sharp),
                  //       ),
                  //       title: Text("Add Item"),
                  //     ),
                  //   ),
                  //   //children: <Widget>[Text("children 1"), Text("children 2")],
                  // ),
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


                  // InkWell(
                  //   onTap: (){

                  //     //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));


                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/user.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("Dashboard"),
                  //     ),
                  //   ),
                  // ),
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
                  // InkWell(
                  //   onTap: (){


                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(10, 0, 0,0),
                  //     child: ListTile(
                  //       leading: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxWidth: 30,
                  //           maxHeight: 30,
                  //         ),
                  //         child: Image.asset("assets/wallet.png", fit: BoxFit.cover),
                  //       ),
                  //       title: Text("My Wallet"),
                  //     ),
                  //   ),
                  // ),
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
                        title: Text("More"),
                      ),
                    ),
                    children: <Widget>[
                      InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 230,
                            maxHeight: 30,
                          ),
                          //child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                        ),
                        title: Text("Service Rules"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          //child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                        ),
                        title: Text("LIcence agreement"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0,0),
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 30,
                            maxHeight: 30,
                          ),
                          //child: Image.asset("assets/myposts.png", fit: BoxFit.cover),
                        ),
                        title: Text("Privacy Policy"),
                      ),
                    ),
                  ),
                      ],
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
                child: Text("Donated Items", style: TextStyle(color: Colors.black))),
            // actions: [
            //   IconButton(
            //     onPressed: () {

            //     },
            //     icon: Icon(Icons.search),
            //     tooltip: 'Search',
            //     color: Colors.black,
            //     iconSize: 30,
            //   ),
            // ],
          ),
          body: DonatedItems()
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

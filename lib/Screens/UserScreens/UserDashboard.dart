import 'package:flutter/material.dart';
import 'package:swap/Screens/ChatScreen.dart';
import 'package:swap/Screens/UserScreens/AddItemsDonate.dart';
import 'package:swap/Screens/UserScreens/AddItemsFlashSale.dart';
import 'package:swap/Screens/UserScreens/AddItemsFriendly.dart';
import 'package:swap/Screens/UserScreens/MyPost.dart';
import 'package:swap/Screens/bartering.dart';
import 'package:swap/Screens/donate.dart';
import 'package:swap/Screens/fresh_sale.dart';
import 'package:swap/Screens/friendly.dart';
import 'package:swap/Widgets/CategoriesList.dart';
import 'package:swap/SplashScreen.dart';
import 'package:swap/Screens/UserScreens/EditProfile.dart';
import 'userItemDetails.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> dummy;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                      Text("User" , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.normal , fontSize: 16),)
                    ],
                  )


                ],
              ),
              SizedBox(height: 10,),
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
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>MyPosts_User()));
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
              
              ListTile(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPost()));
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(100),
                            shape: BoxShape.circle
                          ),
                          child: new Wrap(
                            children: <Widget>[
                              new ListTile(
                                selectedTileColor: Colors.purple[100],
                                focusColor: Colors.purple[100],
                                  //leading: new Icon(Icons.giv),
                                  title: new Text('Donate', style : TextStyle(fontWeight: FontWeight.w600)),
                                  onTap: () {
                                    //_imgFromGallery();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsDonate()));
                                  }),
                                new ListTile(
                                //leading: new Icon(Icons.),
                                title: new Text('Friendly', style : TextStyle(fontWeight: FontWeight.w600)),
                                onTap: () {
                                  //_imgFromGallery();
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFriendly()));
                                }),
                              new ListTile(
                                //leading: new Icon(Icons.photo_camera),
                                title: new Text('Flash Sale', style : TextStyle(fontWeight: FontWeight.w600)),
                                onTap: () {
                                  //_imgFromCamera();
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFlashSale()));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                );
                },
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10,0),
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 30,
                        maxHeight: 30,
                      ),
                      child: Icon(Icons.add_circle_sharp),
                    ),
                    title: Text("Add Item"),
                  ),
                ),
                //children: <Widget>[Text("children 1"), Text("children 2")],
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
      children: <Widget>[
        CategoriesList(dummy),
        Expanded(
          child: Container(
            //color: Colors.black,
            padding: EdgeInsets.fromLTRB(size.width*0.00, 0, 0, size.height*0.02),
            child: GridView.builder(
              //scrollDirection: ,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: size.width*0.02,
                mainAxisSpacing: 0.0,
                crossAxisCount: 2,
                childAspectRatio: 1
                ),
              physics: BouncingScrollPhysics(), 
              itemCount: 7,//data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.startToEnd,
                  background:Container(
                    color: Colors.red,
                    child: Align(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  confirmDismiss: (direction) async {                    
                      final bool res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete ?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                     
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                      return res;
                  },
                  onDismissed: (direction){print("Deleted");},
                  key: Key(index.toString()),
                  child:
                  InkWell(
                    onTap: ()=> Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=>UserItemDetail())),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, size.height*0.01, 0, 0),
                      child: Container(
                        //margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        height: size.height*0.4,
                        width: size.width*0.5,
                        decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300].withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                        children: <Widget>[
                          Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.0),
                            child: Container(
                              child: ClipRect(
                                  
                                  child: Image.asset('assets/burger.png',
                                  height: size.height*0.15,
                                  fit: BoxFit.contain,
                                  )
                                // radius: size.height*0.06,
                                // backgroundImage: AssetImage('assets/burger.png'),
                            ),
                            ),
                            ),
                            Container(
                              height: size.height*0.06,
                              //color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Burger ",
                                maxLines:2,
                                style: TextStyle(fontSize:14,fontWeight: FontWeight.w500),),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(size.width*0.1, 0, size.width*0.1, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text.rich(TextSpan(
                          text: '\u20b9 200',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          )
                        ),),
                        
                        Text("\u20b9 100", style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w600, 
                          fontSize: size.height*0.02))
                                    ]
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: size.height*0.01
                            // ),
                            // Text("Add to Cart", style: TextStyle( fontSize: 15, fontWeight: FontWeight.w500, color: Colors.purple )),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text.rich(
                            //     TextSpan(
                            //       //text: 'This is item cost',
                            //       children:<TextSpan>[
                            //         TextSpan(
                            //           text: '\u20b9 200',
                            //           style: TextStyle(
                            //             color: Colors.grey,
                            //             decoration: TextDecoration.lineThrough,
                            //           )
                            //         ),
                            //         TextSpan(text: '\u20b9 100')
                            //       ]
                            //     )
                            //   ),
                            // ),
                            Column(
                          children: <Widget>[
                            
                            // SizedBox(
                            //   height: size.height*0.02
                            // ),
                            // Container(                          
                            //   height: size.height*0.05,
                            //   width: size.width*0.4, 
                            //   child: Text("This is my last hurrah",
                            //   overflow:TextOverflow.clip,
                            //   softWrap: true,style: TextStyle(fontSize:13,color: Colors.black45),),
                            // )
                          ],
                            ),
                        ],
                          ),
                        ),
                    ),
                  )
                  
                );
              },
            ),
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
    );
  }
}

import 'dart:convert';
import 'package:swap/Screens/BusinessScreens/ownerItemDetails.dart';
import 'package:swap/Widgets/CategoriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';

List productList = [];
class MyPosts_Business extends StatefulWidget {
  final List pl;
 const MyPosts_Business ({ Key key, this.pl }): super(key: key);
  
  @override
  MyPosts_BusinessState createState() => MyPosts_BusinessState();
}

class MyPosts_BusinessState extends State<MyPosts_Business> {
  var data;
  List<String> dummy;
  bool productFlag = false;
  Future<String> getData() async {
    http.Response  response = await http.get('$path/product',);   
    Map<String, dynamic> prodlst = jsonDecode(response.body);
    productList = prodlst['data']['products'] as List;
    print(productList.length);
    productList[0]['price'];
    //Navigator.pop(context);
    setState(() {
        productFlag = true;
    });
    // for(var i in productList)
    //   print(i);
    // if(productList!=null)
    // {
    
    //   setState(() {      
    //   });
    // }
    //return "success";
  }
  

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading:  true,
        backgroundColor: Colors.white,
        title:Text("My Post", style: TextStyle(color: Colors.black)),
      ),
      body: productFlag?
        RefreshIndicator(
          onRefresh: () {
              getData();
              return Future.delayed(
                Duration(seconds: 1),
                () {
                },
              );
            },
          child: Column(
            children: <Widget>[
              //CategoriesList(dummy),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(size.width*0.00, 0, 0, size.height*0.02),
                  child:GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: size.width*0.02,
                      mainAxisSpacing: 0.0,
                      crossAxisCount: 2,
                      childAspectRatio: 1
                      ),
                    //physics: BouncingScrollPhysics(), 
                    itemCount: 
                    //widget.pl==null?
                    productList.length,
                    //:widget.pl.length,//data == null ? 0 : data.length,
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
                            MaterialPageRoute(builder: (context)=>OwnerItemDetail(details: productList[index]))),
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
                                        //     Text.rich(TextSpan(
                                        //   text: '\u20b9 200',
                                        //   style: TextStyle(
                                        //     color: Colors.grey,
                                        //     decoration: TextDecoration.lineThrough,
                                        //   )
                                        // ),
                                        // ),
                                        
                                        Text(productList[0]['price'].toString(), style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.w600, 
                                          fontSize: size.height*0.02))
                                                    ]
                                                  ),
                                                ),
                                              ],
                                        ),
                                  Column(
                                children: <Widget>[
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
        ):
        AlertDialog(
            title:Row( 
              children:<Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.indigo, 
                  strokeWidth: 6.0,
                ),
                SizedBox(width: size.width*0.1),
                Text("Loading")
              ]
            )
          ),
    );
  }
}

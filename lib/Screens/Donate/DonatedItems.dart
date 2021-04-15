import 'dart:convert';
import 'package:swap/Screens/Donate/DonatedItemsDetail.dart';
import 'package:swap/Widgets/CategoriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swap/Screens/FoodCard.dart';
import 'package:swap/Screens/bartering.dart';
import 'package:swap/Screens/map.dart';
//import 'package:swap/Screens/scrollDonatedItems.dart';

class DonatedItems extends StatefulWidget {
  @override
  _DonatedItemsState createState() => _DonatedItemsState();
}

class _DonatedItemsState extends State<DonatedItems> {
  List<String> dummy;
  var data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://food-swap.herokuapp.com/menu/DonatedItems"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      data = jsonDecode(response.body);
    });
    return "Success!";
  }
  

  @override
  void initState() {
    super.initState();
    //this.getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //floatingActionButton: FloatingActionButton(onPressed: (){print("Viola");},),
      backgroundColor: Color(0xffE9E9E9),
      // body: SlidingUpPanel(
      //   backdropEnabled: false,
      //   minHeight: size.height*0.2,
      //   maxHeight: 300,
      //   panelBuilder: (scrollController) =>
      //       buildSlidingPanel(scrollController: scrollController),
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
                          MaterialPageRoute(builder: (context)=>DonatedItemsDetail())),
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
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //       children: <Widget>[
                            //         Padding(
                            //           padding: EdgeInsets.fromLTRB(size.width*0.1, 0, size.width*0.1, 0),
                            //           child: Row(
                            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //             children: <Widget>[
                            //               Text.rich(TextSpan(
                            //   text: '\u20b9 200',
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //     decoration: TextDecoration.lineThrough,
                            //   )
                            // ),),
                            
                            // Text("\u20b9 100", style: TextStyle(
                            //   color: Colors.purple,
                            //   fontWeight: FontWeight.w600, 
                            //   fontSize: size.height*0.02))
                            //             ]
                            //           ),
                            //         ),
                            //       ],
                            //     ),
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
      //),
    );
  }
}

// Widget buildSlidingPanel({
//   @required ScrollController scrollController,
// }) =>
//     scrollDonatedItems();

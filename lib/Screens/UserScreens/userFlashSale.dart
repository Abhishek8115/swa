import 'dart:convert';
import 'package:swap/Screens/UserScreens/userItemDetails.dart';
import 'package:swap/Widgets/CategoriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
//import 'package:swap/Screens/BusinessScreens/BusinessDashboard.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swap/global.dart';

List productList = [];
List catList ;
class UserFlashSale extends StatefulWidget {
List pl, catList;
UserFlashSale ({ Key key, this.pl , this.catList}): super(key: key);
  
  @override
  UserFlashSaleState createState() => UserFlashSaleState();
}

class UserFlashSaleState extends State<UserFlashSale> {
  var data;
  List<String> dummy;
  bool productFlag = false;
  //List pl;
  // UserFlashSaleState(){
  //   getData();
  //   print("calling getData()");
  // }
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  //ap<String, dynamic> productDetails = pl['data']['products'];
  // UserFlashSaleState(){
  //   print(widget.pl);
  // }
 
  Future<String> getData() async {
    http.Response  response = await http.get('$path/product',);   
    Map<String, dynamic> prodlst = jsonDecode(response.body);
    widget.pl = prodlst['data']['products'] as List;
    // print(productList.length);
    // productList[0]['price'];
    http.Response  result = await http.get('$path/category',);   
    Map<dynamic, dynamic> catlst = jsonDecode(result.body);
    print('getData called');
    print(catlst['data']['categories']);
    widget.catList = catlst['data']['categories'];
    print("\n \n \n \n ${widget.catList}");
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
    //Navigator.pop(context);
    //print(pl['data']['products']);
    //print(productList.length);
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
        body: 
        RefreshIndicator(
          onRefresh: () {
              getData();
              return Future.delayed(
                Duration(seconds: 1),
                () {
                    //print("refreshed");
                  // showSnackBar(
                  //   SnackBar(
                  //     content: const Text('Page Refreshed'),
                  //   ),
                  // );
                },
              );
            },
          child: Column(
            // physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              CategoriesList(categories: widget.catList),
              widget.pl.length == 0?
              Padding(
                padding:  EdgeInsets.symmetric(vertical : size.height*0.3),
                child: Text("Nothing added", style: TextStyle(color: Colors.black54, fontSize:size.height*0.05)
                  ),
              ):
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
                    widget.pl.length,
                    //:widget.pl.length,//data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()=> Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>UserItemDetail(details: widget.pl[index]))),
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
                                    child: Text(widget.pl[index]['name'],
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
                                      
                                      Text(widget.pl[index]['price'].toString(), style: TextStyle(
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
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
        ,
      //),
    );
  }
}

// Widget buildSlidingPanel({
//   @required ScrollController scrollController,
// }) =>
//     scrollfreshsale();

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
int selectedIndex = 0;
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
 
  Future<String> getData(selectedIndex) async {
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
                  backgroundColor: Colors.blue[100], 
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
    http.Response  result = await http.get('$path/category',);   
    Map<dynamic, dynamic> catlst = {};
    catlst = jsonDecode(result.body);
    print('getData called');
    //print(catlst['data']['categories']);
    widget.catList = catlst['data']['categories'];
    print("\n \n \n \n ${widget.catList[selectedIndex]['name'].toString()}");

    http.Response  response = await http.get('$path/product?category=${widget.catList[selectedIndex]['name'].toString()}');
    Map<String, dynamic> prodlst = jsonDecode(response.body);
    widget.pl = prodlst['data']['products'] as List;

    if(widget.pl.length == 0)
      print("The products are empty");
    print(widget.pl);
    Navigator.pop(context);
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
    //getData();
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
        Column(
          // physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(
              height: 50,
                  child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.catList==null?0:widget.catList.length,
                itemBuilder: (BuildContext context, index){
                  return Padding(
                    padding:  EdgeInsets.fromLTRB(0, size.height*0.01,size.width*0.02,size.height*0.005),
                    child: GestureDetector(
                      onTap: ()async{
                        //await getData();
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
                                      backgroundColor: Colors.blue[100], 
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
                        http.Response  response = await http.get('$path/product?category=${widget.catList[index]['name'].toString()}');
                        Map<String, dynamic> prodlst = jsonDecode(response.body);
                        widget.pl = prodlst['data']['products'] as List;
                        selectedIndex = index;
                        if(widget.pl.length == 0)
                          print("The products are empty");
                        print(widget.pl);
                        Navigator.pop(context);
                        setState(() {
                          print(index);
                          
                        });
                      },
                      child: Container(
                        height: size.height*0.0,
                        decoration: BoxDecoration(
                          color: index==selectedIndex?Colors.grey[200]:Colors.white,
                          borderRadius: BorderRadius.circular(size.height*0.05),
                          boxShadow: index==selectedIndex?[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ]:null,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(size.height*0.01),
                          child: Center(child: Text(widget.catList[index]['name'])),
                        ),
                      ),
                    ),
                  );
              }),
            ),
            // CategoriesList(categories: widget.catList),
            widget.pl.length == 0?
            RefreshIndicator(
              onRefresh: () async{
                print("It is called");
                await getData(selectedIndex);
              },
              child: Column(
                //shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical : size.height*0.3),
                    child: Text("Nothing added", style: TextStyle(color: Colors.black54, fontSize:size.height*0.05)),
                  ),
                ],
                ),
            ):
            RefreshIndicator(
              onRefresh: ()async{
                print("It is called");
                await getData(selectedIndex);
              },
              child: Container(
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

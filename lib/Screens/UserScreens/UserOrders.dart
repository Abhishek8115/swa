import 'package:flutter/material.dart';
import 'package:swap/global.dart';
import 'dart:convert';
import 'package:swap/Screens/UserScreens/OrderDetails.dart';
import 'package:http/http.dart' as http;

class User_Orders extends StatefulWidget {
  @override
  List orders;
  User_Orders({Key key, this.orders}): super(key: key);
  _User_OrdersState createState() => _User_OrdersState();
}
Size size ;
class _User_OrdersState extends State<User_Orders> {
  @override
  void initState() {
    print(widget.orders.length);
    // TODO: implement initState    
    super.initState();
  } 
  @override
  Widget build(BuildContext context) {
    print(widget.orders);
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, 
        ),
        backgroundColor: Colors.white,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: 
      ListView.builder(
        itemCount: widget.orders.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: GestureDetector(
            child: Container(
              child: Column(
                children: [
                Padding(
                padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, size.width*0.02, 0),
                child: GestureDetector(
                  onTap:(){
                  print(widget.orders[index]);
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetails(order: widget.orders[index])));
                  },
                  child: Container(
                    height: size.height*0.1,
                    width: 400,
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
                    borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                        
                        //   Padding(
                        //   padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                        //     child: CircleAvatar(
                        //       radius: size.height*0.05,
                        //       backgroundImage: AssetImage('assets/burger.png'),
                        // ),
                        // ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(size.width*0.03, 0, size.width*0.03, 0),
                                  child: 
                                  Text("${(index + 1).toString()}.",
                                  style: TextStyle(fontSize:22,fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,  size.height*0.01, 0, 0),
                                      child: Text(
                                        widget.orders[index]['orderBy']['name'],
                                        style: TextStyle(fontSize:22,fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height*0.008
                                    ),
                                    Text(
                                      widget.orders[index]['orderBy']['phone'],
                                      style: TextStyle(fontSize:15  ,fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: size.height*0.02
                            // ),                          
                          ],
                        ),
                        Text(
                          widget.orders[index]['status']=="created"?"Pending":
                          widget.orders[index]['status']=="deliver"?"Delivered":"Cancelled",
                          overflow:TextOverflow.clip,
                          softWrap: true,
                          style: TextStyle(
                            fontSize:23,
                            color: widget.orders[index]['status']=="created"?Colors.yellow[800]:
                              widget.orders[index]['status']=="deliver"?Colors.green[400]:Colors.red
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, size.width*0.02, 0),
                          child: Text("\$ ${widget.orders[index]['totalPrice']}", style: TextStyle(fontSize: 15)),
                        ),                            
                        ],                        
                      ),
                      
                    //   Text("Been through 2 steps you're following incoping with depression",
                    //  style:TextStyle(color:Colors.black45,fontSize:13,),)
                    ],
                      ),
                    ),
                  )
                )
                ],
              ),
            ),
          ),
        );
        }
      )
    );
  }
}

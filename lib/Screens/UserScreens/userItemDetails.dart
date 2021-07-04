import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserItemDetail extends StatefulWidget {
  Map<String, dynamic> details;
  UserItemDetail({Key key, this.details}): super(key:key);
  @override
  _UserItemDetailState createState() => _UserItemDetailState();
}
Size size;
bool showButton = false, changeColor = false;
List<Map<String, String>> productList = <Map<String, String>>[];



class _UserItemDetailState extends State<UserItemDetail> {
  
  int quantity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showButton = false;
    changeColor = false;
    quantity = 1;
  }
  @override
  Widget build(BuildContext context) {
    //print(widget.details['price']);
    size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar:AppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: size.height*0.3,
              width: size.width*1,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/Rhombus.gif',
                  image: widget.details['image'],
                  fit: BoxFit.cover,
                  // height: size.height*0.16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width*0.04, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                            child: Container(
                              height: size.height*0.06,
                              //color: Colors.blue,
                              child: Text(widget.details['name'],
                              maxLines:2,
                              style: TextStyle(fontSize:25,fontWeight: FontWeight.w500),),
                            ),
                      ),
                    ),
                        Padding(
                         padding: EdgeInsets.fromLTRB(size.width*0.04, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[                              
                              Text("\u20b9 ${widget.details['price']}", style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w600, 
                                fontSize: size.height*0.04)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(size.width*0.04, size.height*0.02, 0, 0),
                          child: Text("Best before ${widget.details['createdAt'].toString().substring(0,10)}", style: TextStyle(color: Colors.black54)),
                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.height*0.02),
                          child: Text("Description ", style: TextStyle(color: Colors.black87, fontSize:size.height*0.03)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.height*0.02 ),
                          child: Text("${widget.details['description']}", style: TextStyle(color: Colors.black54, fontSize:size.height*0.025)),
                        ),
                        SizedBox(
                          height: size.height*0.32
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              showButton?FlatButton(
                                splashColor: Colors.purple[200],
                                  height: size.height*0.06,
                                  color: Colors.transparent,
                                  onPressed: ()async{
                                    showButton = true;
                                    if(quantity <= 1)
                                      showButton = false;
                                    else
                                      quantity--;
                                    print(quantity.toString());
                                    setState(() {});
                                  },
                                  child: Text("-", style: TextStyle(
                                    fontSize: size.height*0.04,
                                    color: changeColor? Colors.black54: Colors.black,
                                    fontWeight: FontWeight.w400),)
                                ):Text(" "),
                              FlatButton(
                                splashColor: Colors.purple[200],
                                  height: size.height*0.06,
                                  color: Colors.purple,
                                  onPressed: ()async{
                                    
                                    print("Added to Cart");    
                                    if (showButton) {
                                      print("sending to server .....");
                                      Directory directory = await getApplicationDocumentsDirectory();
                                      File file3 = File('${directory.path}/token.txt');
                                      String token = await file3.readAsString();
                                      double price = double.parse(widget.details['price'].toString())*quantity;
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
                                                    backgroundColor: Colors.indigo, 
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
                                      print(jsonEncode({
                                          "cart":{
                                            "totalPrice": price,
                                            "totalQuantity": 1,
                                            "products": [
                                              {
                                                "product": widget.details['_id'],
                                                "quantity": quantity
                                              }
                                            ]
                                          }
                                        }));
                                      var res = await http.patch("$path/profile/cart",
                                        headers:{
                                          "Content-Type": "application/json",
                                          "Authorization": "Bearer $token"
                                        },
                                        body: jsonEncode({
                                          "cart":{
                                            "totalPrice": price,
                                            "totalQuantity": 1,
                                            "products": [
                                              {
                                                "product": widget.details['_id'],
                                                "quantity": quantity
                                              }
                                            ]
                                          }
                                        })
                                      );                                      
                                      Navigator.pop(context);
                                      print(res.body);
                                      showGeneralDialog(
                                        barrierColor: Colors.black.withOpacity(0.5),
                                        transitionBuilder: (context, a1, a2, widget) {
                                        return Transform.scale(
                                        scale: a1.value,
                                        child: Opacity(
                                          opacity: a1.value,
                                          child: AlertDialog(
                                          title:Column( 
                                            children:<Widget>[
                                              // CircularProgressIndicator(
                                              //   backgroundColor: Colors.indigo, 
                                              //   //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                                              //   strokeWidth: 6.0,
                                              // ),
                                              //SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                              Image.asset("assets/successful.gif",
                                                height: MediaQuery.of(context).size.height * 0.1,
                                                width: MediaQuery.of(context).size.width * 0.3,
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.05),
                                              Text("Added to cart")
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
                                        Future.delayed(Duration(milliseconds: 2000)).then((onValue){
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      );                                                                         
                                    }
                                    showButton = true;
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Text("Add to cart",  style: TextStyle(color: Colors.white)),
                                      showButton?
                                      Text("  " + quantity.toString(),  style: TextStyle(color: Colors.white)):
                                      Text(" "),
                                    ],
                                  )
                                ),
                                
                                showButton?
                              FlatButton(
                                splashColor: Colors.purple[200],
                                  //height: size.height*0.06,
                                  color: Colors.transparent,
                                  onPressed: ()async{
                                    showButton = true;
                                    if(quantity>widget.details['quantity'])
                                      changeColor = true;
                                    else
                                      ++quantity;
                                     print(quantity.toString());
                                    setState(() {});
                                  },
                                  child: Text("+", style: TextStyle(
                                    fontSize: size.height*0.04,
                                    color: changeColor? Colors.black54: Colors.black,
                                    fontWeight: FontWeight.w300),)
                                )
                                :Text(" "),
                            ],
                          ),
                        )
                        
          ]
        ),
      )
    );
  }
}
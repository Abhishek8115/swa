import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';
class ItemDetail extends StatefulWidget {
  @override
  _ItemDetailState createState() => _ItemDetailState();
}
Size size;
class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar:AppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: size.height*0.3,
              width: size.width*1,
              child: ClipRect(
                child: Image.asset("assets/burger.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(size.width*0.04, 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                            child: Container(
                              height: size.height*0.06,
                              //color: Colors.blue,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Burger ",
                                maxLines:2,
                                style: TextStyle(fontSize:25,fontWeight: FontWeight.w500),),
                              ),
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
                                Text.rich(TextSpan(
                      text: '\u20b9 200',
                      style: TextStyle(
                                fontSize: size.height*0.03,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                      )
                    ),),
                    
                    Text("\u20b9 100", style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600, 
                      fontSize: size.height*0.04)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(size.width*0.04, 0, 0, 0),
                          child: Text("Best before March 15, 2021", style: TextStyle(color: Colors.black54)),
                        ),
                        SizedBox(
                          height: size.height*0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.add, color: Colors.purple), onPressed:(){}),
                            Text("1", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 30)),
                            IconButton(icon: Icon(Icons.remove, color: Colors.purple), onPressed:(){})
                          ],
                        ),
                        SizedBox(
                          height: size.height*0.32
                        ),
                        FlatButton(
                          splashColor: Colors.purple[200],
                            height: size.height*0.06,
                            color: Colors.purple,
                            onPressed: ()async{
                              final response = await http.post('$path/addToCart',
                                headers: {
                                  //HttpHeaders.contentTypeHeader: "application/json",
                                  "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250YWN0TnVtYmVyIjoiNDIxNDIyNyIsInVzZXJJZCI6IjYwNjljYTYzZDgzNDkwMDAxN2EyN2I0ZCIsImRhdGUiOiIyMDIxLTA0LTA0VDE0OjQyOjA5LjIzNloiLCJpYXQiOjE2MTc1NDczMjl9.oi3qaowd3Ct0NP3fPzsemJaMTHqkstlasalnIN5oAIU"
                                },
                                body: jsonEncode({
                                  'productId':'5fe875b6b72ad83b88ecce31'
                                })
                              );
                              //Map<String , dynamic> details = jsonDecode(response.body);
                              Map<String, dynamic> details= jsonDecode(response.body);
                              print(details);
                              print('response : ${response.body}');
                            },
                            child: Text("Add to cart",  style: TextStyle(color: Colors.white))
                          )
          ]
        ),
      )
    );
  }
}
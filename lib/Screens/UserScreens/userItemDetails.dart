import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';


class UserItemDetail extends StatefulWidget {
  Map<String, dynamic> details;
  UserItemDetail({Key key, this.details}): super(key:key);
  @override
  _UserItemDetailState createState() => _UserItemDetailState();
}
Size size;
class _UserItemDetailState extends State<UserItemDetail> {
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
                          child: FlatButton(
                            splashColor: Colors.purple[200],
                              height: size.height*0.06,
                              color: Colors.purple,
                              onPressed: ()async{
                                // final response = await http.post('$path/addToCart',
                                //   headers: {
                                //     //HttpHeaders.contentTypeHeader: "application/json",
                                //     "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250YWN0TnVtYmVyIjoiNDIxNDIyNyIsInVzZXJJZCI6IjYwNjljYTYzZDgzNDkwMDAxN2EyN2I0ZCIsImRhdGUiOiIyMDIxLTA0LTA0VDE0OjQyOjA5LjIzNloiLCJpYXQiOjE2MTc1NDczMjl9.oi3qaowd3Ct0NP3fPzsemJaMTHqkstlasalnIN5oAIU"
                                //   },
                                //   body: jsonEncode({
                                //     'productId':'5fe875b6b72ad83b88ecce31'
                                //   })
                                // );
                                // //Map<String , dynamic> details = jsonDecode(response.body);
                                // Map<String, dynamic> details= jsonDecode(response.body);
                                // print(details);
                                // print('response : ${response.body}');
                              },
                              child: Text("Add to cart",  style: TextStyle(color: Colors.white))
                            ),
                        )
                        
          ]
        ),
      )
    );
  }
}
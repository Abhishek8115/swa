import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';


class ItemDetail extends StatefulWidget {
  Map<String, dynamic> details;
  ItemDetail({Key key, this.details}): super(key:key);
  @override
  _ItemDetailState createState() => _ItemDetailState();
}
Size size;
class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.details['price']);
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.details['name'],
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
                              
                              Text("\u20b9 ${widget.details['price']}", style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w600, 
                                fontSize: size.height*0.04)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(size.width*0.04, 0, 0, 0),
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
                        
          ]
        ),
      )
    );
  }
}
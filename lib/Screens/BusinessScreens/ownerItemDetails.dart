import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';
import 'package:swap/Screens/BusinessScreens/UpdateItem.dart';

class OwnerItemDetail extends StatefulWidget {
  Map<String, dynamic> details;
  OwnerItemDetail({Key key, this.details}): super(key:key);
  @override
  _OwnerItemDetailState createState() => _OwnerItemDetailState();
}
Size size;
class _OwnerItemDetailState extends State<OwnerItemDetail> {
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.details['_id'],
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
                child: Text("Best before ${widget.details['createdAt']}", style: TextStyle(color: Colors.black54)),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  FlatButton(           
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),          
                    splashColor: Colors.greenAccent[100],
                      height: size.height*0.05,
                      color: Colors.greenAccent[400],
                      onPressed: ()async{
                       Navigator.push(context, 
                            MaterialPageRoute(builder: (conttext)=>UpdateItem()));                      },
                      child: Text("Update",  style: TextStyle(color: Colors.white))
                    ),
                    FlatButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.red[200],
                      height: size.height*0.05,
                      color: Colors.red,
                      onPressed: ()async{
                      },
                      child: Text("Delete",  style: TextStyle(color: Colors.white))
                    ),
                ]
              ),
              Padding(
                padding: EdgeInsets.all(size.height*0.02),
                child: Text("Description ", style: TextStyle(color: Colors.black87, fontSize:size.height*0.03)),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.height*0.02 ),
                child: Text("Description will be written here", style: TextStyle(color: Colors.black54, fontSize:size.height*0.025)),
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
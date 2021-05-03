import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:convert/convert.dart';
import 'package:swap/Screens/UserScreens/UserUpdateItem.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:swap/global.dart';

class UserPostItemDetail extends StatefulWidget {
  Map<String, dynamic> details;
  List categoryList;
  UserPostItemDetail({Key key, this.details, this.categoryList}): super(key:key);
  @override
  _UserPostItemDetailState createState() => _UserPostItemDetailState();
}
Size size;
//String id = widget.details['_id'];
class _UserPostItemDetailState extends State<UserPostItemDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.details);
  }
  void delete()async{
    Navigator.pop(context);
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
                SizedBox(width: size.width*0.1),
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
   
    Directory directory = await getApplicationDocumentsDirectory(); 
    File file3 = File('${directory.path}/token.txt');
    String token = await file3.readAsString();
    var res = await http.delete("$path/product/${widget.details['_id']}",
      headers:{
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }
    );
    print("Item deleted");      
    print(res.body);   
    
    Navigator.pop(context);  
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
                Text("Product deleted")
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
    Future.delayed(Duration(milliseconds: 2000)).then((onValue)=>Navigator.pop(context));                       
  }
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
                padding: EdgeInsets.fromLTRB(size.width*0.04, size.height*0.02, 0, 0),
                child: Text("Best before ${widget.details['createdAt'].toString().substring(0,10)}", style: TextStyle(color: Colors.black54)),
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
                        print(" catList2: ${widget.categoryList}");
                       Navigator.push(context, 
                            MaterialPageRoute(builder: (context)=>UserUpdateItem(catList: widget.categoryList, id: widget.details['_id'])));                      },
                      child: Text("Update",  style: TextStyle(color: Colors.white))
                    ),
                    FlatButton(
                      
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.red[200],
                      height: size.height*0.05,
                      color: Colors.red,
                      onPressed: ()async{
                        print("Delete called");
                        showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionBuilder: (context, a1, a2, widget) {
                            return Transform.scale(
                              scale: a1.value,
                              child: Opacity(
                                opacity: a1.value,
                                child: AlertDialog(
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
                                        onPressed: () async{
                                            await delete();
                                          setState(() {
                                           
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
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
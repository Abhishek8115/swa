import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DonatedItemsDetail extends StatefulWidget {
  @override
  _DonatedItemsDetailState createState() => _DonatedItemsDetailState();
}
Size size;
class _DonatedItemsDetailState extends State<DonatedItemsDetail> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar:AppBar(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: size.height*0.375,
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
                         padding: EdgeInsets.fromLTRB(size.width*0.05, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text.rich(TextSpan(
                      text: 'By : ',
                      style: TextStyle(
                                fontSize: size.height*0.03,
                                color: Colors.grey,
                                //decoration: TextDecoration.lineThrough,
                      )
                    ),),
                    
                    Text("Abhishek Singh", style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600, 
                      fontSize: size.height*0.03)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(size.width*0.05, 0, 0, 0),
                          child: Text("Best before March 15, 2021", style: TextStyle(color: Colors.black54)),
                        ),
                        SizedBox(
                          height: size.height*0.1,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     IconButton(icon: Icon(Icons.add, color: Colors.purple), onPressed:(){}),
                        //     Text("1", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 30)),
                        //     IconButton(icon: Icon(Icons.remove, color: Colors.purple), onPressed:(){})
                        //   ],
                        // ),
                        SizedBox(
                          height: size.height*0.32
                        ),
                        FlatButton(
                          splashColor: Colors.purple[200],
                            height: size.height*0.06,
                            color: Colors.purple,
                            onPressed: (){
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return SafeArea(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //borderRadius: BorderRadius.circular(100),
                                        shape: BoxShape.circle
                                      ),
                                      child: new Wrap(
                                        children: <Widget>[
                                          new ListTile(
                                            selectedTileColor: Colors.purple[100],
                                            focusColor: Colors.purple[100],
                                              leading: new Icon(Icons.mail_outline, color: Colors.purple[400],),
                                              title: new Text('E-Mail', style : TextStyle(fontWeight: FontWeight.w600)),
                                              onTap: () {
                                                //_imgFromGallery();
                                                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsDonate()));
                                              }),
                                            new ListTile(
                                            leading: new Icon(Icons.call_end_outlined, color: Colors.purple[400],),
                                            title: new Text('Call', style : TextStyle(fontWeight: FontWeight.w600)),
                                            onTap: () {
                                              //_imgFromGallery();
                                             // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFriendly()));
                                            }),
                                          new ListTile(
                                            leading: new Icon(Icons.chat_outlined, color: Colors.purple[400],),
                                            title: new Text('Chat', style : TextStyle(fontWeight: FontWeight.w600)),
                                            onTap: () {
                                              //_imgFromCamera();
                                            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemsFlashSale()));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            );
                            },
                            child: Text("Contact Donor",  style: TextStyle(color: Colors.white))
                          )
          ]
        ),
      )
    );
  }
}
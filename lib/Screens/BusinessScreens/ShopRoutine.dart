import 'package:flutter/material.dart';

class ShoppingRoutine extends StatefulWidget {
  @override
  _ShoppingRoutineState createState() => _ShoppingRoutineState();
}
Size size;
class _ShoppingRoutineState extends State<ShoppingRoutine> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Clint Cafe", style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.03),),
      //   backgroundColor: Colors.purple
      // ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.arrow_back_rounded, color: Colors.purple[900], size: size.height*0.03,)
                ),
                SizedBox(width: size.width*0.02),
                Text("Clint Cafe", style: TextStyle(fontSize:size.height*0.025, fontWeight: FontWeight.w500) ),
                
              ],
            ),
          ),
          SizedBox(height: size.height*0.02),
          Container(
            margin: EdgeInsets.fromLTRB(size.width*0.02, 0, size.width*0.02, 0),
            height: size.height*0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height*0.01, horizontal: size.width*0.02),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("HOUR", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
                Padding(
                  padding:EdgeInsets.symmetric(vertical: size.height*0.00, horizontal: size.width*0.02),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text("Sunday", style: TextStyle(fontSize:size.height*0.025, fontWeight: FontWeight.w400) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),
                      SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Monday", style: TextStyle(fontSize:size.height*0.025) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Tuesday", style: TextStyle(fontSize:size.height*0.025) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Wednesday", style: TextStyle(fontSize:size.height*0.025, fontWeight: FontWeight.bold) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02, fontWeight: FontWeight.bold))
                      ],),SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Thursday", style: TextStyle(fontSize:size.height*0.025) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Friday", style: TextStyle(fontSize:size.height*0.025) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),SizedBox(height: size.height*0.005),
                      Row(children: <Widget>[
                        Text("Saturday", style: TextStyle(fontSize:size.height*0.025) ),
                        Spacer(),
                        Text("8a.m -9p.m", style: TextStyle(fontSize:size.height*0.02))
                      ],),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("STORE TYPE", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.01, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: size.height*0.06,
                          width: size.width*0.12,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Icons.shopping_cart_outlined, color: Colors.white)
                        ),
                      ),
                      SizedBox(width: size.width*0.02),
                      Text("Cafe ", style: TextStyle(fontSize:size.height*0.025) ),
                    ],
                  ),
                )
              ],
            )
          ),
          SizedBox(height: size.height*0.02),
          Container(
            margin: EdgeInsets.fromLTRB(size.width*0.02, 0, size.width*0.02, 0),
            height: size.height*0.22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("Pickup", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.01, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: 
                    Text("Please visit VC Express for order pickup and confirmation", 
                    style: TextStyle(color: Colors.black87, fontSize:size.height*0.02, fontWeight: FontWeight.w700))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("Checkout", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.01, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: 
                    Text("Please visit VC Express for order pickup and confirmation", 
                    style: TextStyle(color: Colors.black87, fontSize:size.height*0.02, fontWeight: FontWeight.w700))),
                ),
            ],)
          ),
          SizedBox(height: size.height*0.02),
          Container(
            margin: EdgeInsets.fromLTRB(size.width*0.02, 0, size.width*0.02, 0),
            height: size.height*0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("Number", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.01, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: 
                    Text("+91 9574871235", 
                    style: TextStyle(color: Colors.purpleAccent[400], fontSize:size.height*0.02, fontWeight: FontWeight.w700))),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.02, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: Text("EMAIL", style: TextStyle(color: Colors.black54, fontSize:size.height*0.02))),
                ),
              Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.02, size.height*0.01, 0, 0),
                  child: Align(alignment:Alignment.topLeft,
                    child: 
                    Text("contact@flashfood.com", 
                    style: TextStyle(color: Colors.purpleAccent[400], fontSize:size.height*0.02, fontWeight: FontWeight.w700))),
                ),
            ],)
          )
        ],
      )
    );
  }
}
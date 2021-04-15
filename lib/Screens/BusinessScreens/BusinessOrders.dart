import 'package:flutter/material.dart';

class Business_Orders extends StatefulWidget {
  @override
  _Business_OrdersState createState() => _Business_OrdersState();
}
Size size ;
class _Business_OrdersState extends State<Business_Orders> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Order_Card(),
          Order_Card(),
          Order_Card(),
          Order_Card(),
          Order_Card(),
        ],
      ),
    );
  }

  Widget Order_Card() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: GestureDetector(
        child: Container(
          child: Column(
            children: [
             Padding(
              padding: EdgeInsets.fromLTRB(size.width*0.04, size.height*0.02, size.width*0.04, 0),
              child: Container(
              height: size.height*0.15,
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:<Widget>[
                    Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                      child: CircleAvatar(
                        radius: size.height*0.05,
                        backgroundImage: AssetImage('assets/burger.png'),
                  ),
                  ),
                  Column(
                    children: <Widget>[
                      Text("Burger",style: TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: size.height*0.02
                      ),
                      Container(                          
                        height: size.height*0.05,
                        width: size.width*0.4, 
                        child: Text("This is my last hurrah",
                        overflow:TextOverflow.clip,
                        softWrap: true,style: TextStyle(fontSize:13,color: Colors.black45),),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("5", style:TextStyle(fontSize: 30)),
                    //  Icon(Icons.shopping_cart),
                     SizedBox(
                       height: size.height*0.01
                     ),
                     Text("\$ 15", style: TextStyle(fontSize: 10)),
                    ],
                  ),                            
                  ],                        
                ),
                
              //   Text("Been through 2 steps you're following incoping with depression",
              //  style:TextStyle(color:Colors.black45,fontSize:13,),)
              ],
                ),
              )
            )
            ],
          ),
        ),
      ),
    );
  }
}

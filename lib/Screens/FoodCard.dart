import 'package:flutter/material.dart';

class FoodCard extends StatefulWidget {
  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
           child:Padding(
               padding: EdgeInsets.fromLTRB(size.width*0.05, size.height*0.02, size.width*0.05, 0),
               child: Container(
               height: size.height*0.15,
               width: 300,
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
                borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      Padding(
                       padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                         child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/burger.png'),
                     ),
                     ),
                     Column(
                       children: <Widget>[
                        Text("Burger",style: TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                        Text("This is my last hurrah ",style: TextStyle(fontSize:13,color: Colors.black45),)
                       ],
                     ),
                     Column(
                       children: <Widget>[
                        Icon(Icons.edit)
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
        );
  }
}
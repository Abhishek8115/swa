import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap/Screens/BarteringChat.dart';
import 'package:swap/Screens/BarteringViewFood.dart';
import 'map.dart';


class scrollbarsale extends StatefulWidget {
  const scrollbarsale({
    Key key,
    this.scrollController,
  }):super(key:key);
  final ScrollController scrollController;
  @override
  _scrollbarsaleState createState() => _scrollbarsaleState();
}

class _scrollbarsaleState extends State<scrollbarsale> {
  @override
  Widget build(BuildContext context) {


    return Container(
        child:Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Icon(Icons.drag_handle,color: Color(0xffD8D8D8),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Quick Swap",
                              style: TextStyle(
                                  fontSize:30
                              )
                          ),Text("1 item in Cart",
                              style: TextStyle(
                                  fontSize:20,
                                  color: Color(0xffD8D8D8)
                              )
                          ),]

                    ),
            InkWell(
            onTap: (){



              Navigator.push(context, MaterialPageRoute(builder: (context) => BarteringViewFood()));





            },
            child: Image.asset("assets/food.png" , width: 50, height: 50,)),

                      ]),
                SizedBox(height: 10,),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: bd.length,
                    itemBuilder:  (BuildContext context, int index) {
                      return Container(
                        child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(bd[index].Name,
                                    style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                    Text("in need of ${bd[index].need}",)
                                      ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[



                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (bd[index].Counter > 1) {
                                            bd[index].Counter--;
                                          }
                                         else if (bd[index].Counter == 1) {
                                            bd.removeAt(index);

                                          }
                                        });
                                      },
                                      color: Colors.green,
                                    ),
                                    Text(bd[index].Counter.toString()),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      color: Colors.green,
                                      onPressed: () {
                                        setState(() {
                                          bd[index].Counter++;
                                        });
                                      },
                                    ),
                                  ],
                                ),


                              ],
                            )




                        ),
                      );

                    }
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Options : "  , textAlign: TextAlign.start,),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/handshake.png" , width: 50 , height: 50,),
                          SizedBox(width: 10,),
                          Text("Pickup",style: TextStyle(color: Colors.black , fontSize: 18),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset("assets/placeholder.png" , width: 50 , height: 50,),
                          SizedBox(width: 10,),
                          Text("MeetUp",style: TextStyle(color: Colors.black , fontSize: 18),),

                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xff62319E),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: Center(
                              child: Text('Swap Now',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                            onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => BarteringChat()));

                            }
                        )
                      ],
                    ),
                  ),
                ),

              ],

            )




        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap/Screens/CartPage.dart';
import 'map.dart';


class scrollfreshsale extends StatefulWidget {
  const scrollfreshsale({
    Key key,
    this.scrollController,
  }):super(key:key);
  final ScrollController scrollController;
  @override
  _scrollfreshsaleState createState() => _scrollfreshsaleState();
}

class _scrollfreshsaleState extends State<scrollfreshsale> {
  @override
  Widget build(BuildContext context) {


    return Container(
      child:Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Icon(Icons.drag_handle,color: Color(0xffD8D8D8),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Column(
                children: [
                  Text("Quick Checkout",
                      style: TextStyle(
                          fontSize:30
                      )
                  ),
                  // Text("Swipe Up for full screen",
                  //     style: TextStyle(
                  //         fontSize:20,
                  //       color: Color(0xffD8D8D8)
                  //     )
                  // ),
                  ]

              ),

                InkWell(
                    onTap: (){



                    },
                    child: Image.asset("assets/food.png" , width: 50, height: 50,)),
             //Icon(Icons.fullscreen_exit_outlined,size: 40,color: Color(0xff62319E),)

                ]),
                ListView.builder(
                    shrinkWrap: true,
                  itemCount: itemData.length,
                    itemBuilder:  (BuildContext context, int index) {
                    return Container(
                      child: ListTile(


                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [Text(itemData[index].Name,
                                style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                                Text(itemData[index].price.toString()),],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[



                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (itemData[index].Counter > 0) {
                                        itemData[index].Counter--;
                                      }
                                    });
                                  },
                                  color: Colors.green,
                                ),
                                Text(itemData[index].Counter.toString()),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.green,
                                  onPressed: () {
                                    setState(() {
                                      itemData[index].Counter++;
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
            Container(
              height: 70,
         
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color:Colors.black),
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(

                    ),
                    child:InkWell(
                    child: Column(
                      children: [
                          Text("Pay with Card", style: TextStyle(color: Colors.black54)),
                          //Text("Card"),
                          // ClipRect(
                          //   height: 40,
                          //   child: Image.asset("assets/creditcard.png"))
                          Tab(icon: Image.asset("assets/creditcard.png"))
                      ],
                  ),
                    ),
                  ),
                  Container( child:InkWell(
                    child: Column(
                      children: [
                        Text("Pay Online", style: TextStyle(color: Colors.black54)),
                        //Text("Online"),
                        Tab(icon: Image.asset("assets/onlinepayment.png"))
                      ],
                    ),
                  ),)

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
                        child: Text('Order Now',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat')),
                      ),
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));



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

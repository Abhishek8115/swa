import 'package:flutter/material.dart';
import 'package:swap/Screens/Chat_Details_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  Map<String, dynamic> order ;
  OrderDetails({Key key, this.order}): super(key: key); 
  @override
  _OrderDetailsState createState() => _OrderDetailsState();

}

class _OrderDetailsState extends State<OrderDetails> {
  
  int stepper(){
    int step;
    //widget.order['status'] = "deliver";
    if(widget.order['status'] == "created")
      step = 0;
    else if(widget.order['status'] == "packing")
      step = 1;
    else
      step = 2;
    return step;    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height*0.05),
          Container(
            margin: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width*0.02, 0,  MediaQuery.of(context).size.width*0.02, 0),
            height:  MediaQuery.of(context).size.height*0.1,
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
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03,  MediaQuery.of(context).size.height*0.01, 0, 0),
                  child: Row(children: <Widget>[
                    Text("OrderId : ",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height*0.023)
                    ),
                    Text(widget.order['_id'],
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: MediaQuery.of(context).size.height*0.023)
                    )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03, MediaQuery.of(context).size.height*0.01, 0, 0),
                  child: Row(children: <Widget>[
                    Text("Total Price : ",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height*0.023)
                      ),
                    Text("\$ ${widget.order['totalPrice'].toString()}",
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: MediaQuery.of(context).size.height*0.023)
                    )
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03, MediaQuery.of(context).size.height*0.01, 0, 0),
                //   child: Row(children: <Widget>[
                //     Text("By : ",
                //       style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.height*0.023)
                //       ),
                //     Text(widget.order['orderBy']['name'],
                //       style: TextStyle(fontWeight: FontWeight.w300, fontSize: MediaQuery.of(context).size.height*0.023)
                //     )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03, MediaQuery.of(context).size.height*0.01, 0, 0),
                //   child: Row(children: <Widget>[
                //     Text("Phone Number : ",
                //       style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.height*0.023)
                //       ),
                //     Text(widget.order['orderBy']['phone'],
                //       style: TextStyle(fontWeight: FontWeight.w300, fontSize: MediaQuery.of(context).size.height*0.023)
                //     )
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03, MediaQuery.of(context).size.height*0.01, 0, 0),
                //   child: Row(children: <Widget>[
                //     Text("Adderss : ",
                //       style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.height*0.023)
                //       ),
                //     Text(widget.order['orderBy']['addresses'].length == 0? "Not specified ": widget.order['orderBy']['addresses'][0].toString(),
                //       style: TextStyle(fontWeight: FontWeight.w300, fontSize: MediaQuery.of(context).size.height*0.023)
                //     )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02),
          Container(
            margin: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width*0.02, 0,  MediaQuery.of(context).size.width*0.02, 0),
            height:  MediaQuery.of(context).size.height*0.1,
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
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width*0.03, 0, 0, 0),
                  child: Text("Contact ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: MediaQuery.of(context).size.height*0.023)
                  ),
                ),
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChatDetailPage()
                    )
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width*0.47, 
                      MediaQuery.of(context).size.height*0.025, 
                      MediaQuery.of(context).size.width*0.06, 
                      MediaQuery.of(context).size.height*0.025
                    ),
                    child: Image.asset("assets/chat.png", fit: BoxFit.cover),
                  ),
                ),
                InkWell(
                  onTap: ()async=> await launch("tel: 1234567890"),
                  child: Icon(Icons.call_outlined, size: MediaQuery.of(context).size.height*0.05))
              ]
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02),
          Center(
            child: FlatButton(                      
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            splashColor: Colors.red[200],
              height: MediaQuery.of(context).size.height*0.05,
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
                                "Are you sure you want to Cancel ?"),
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
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async{                                           
                                    
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
              child: Text("Cancel order",  style: TextStyle(color: Colors.white))
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width*0.03, 
                MediaQuery.of(context).size.height*0.01, 
                MediaQuery.of(context).size.width*0.03, 
                MediaQuery.of(context).size.height*0.01
              ),
            child: Container(               
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
              child: Stepper(
                currentStep: stepper(),
                onStepCancel: null,
                steps:<Step>[
                  Step(
                    title: Text("Order Placed"),
                    content: Text("Your order is successfully placed "),
                    isActive: stepper() >= 0? true:false,
                    state: StepState.complete
                  ),
                  Step(
                    title: Text("Packed"),
                    content: Text("Your order has been picked up by our courirer partner"),
                    isActive: stepper() >= 1? true:false,
                    state: stepper() >= 1? StepState.complete:  StepState.indexed
                  ),
                  Step(
                    title: Text("Delivered"),
                    content: Text("Your item has been delivered"),
                    isActive: stepper() == 2? true:false,
                    state: stepper() == 2? StepState.complete:  StepState.indexed
                  )
                  
                ]
              ),
            ),
          )
        ]
      )
    );
  }
}
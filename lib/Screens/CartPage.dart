import 'package:flutter/material.dart';
import 'package:swap/Screens/PaymentModePage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:swap/global.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}
// class CartDetails{
//   String product;
//   int quantity;
//   CartDetails(this.product, this.quantity);
//   factory CartDetails.fromJson(Map<String, dynamic> json){
//     return CartDetails(json['product'], json['quantity']);
//   }
// }

List<dynamic> pr = [];
String token;
class _CartPageState extends State<CartPage> {
  
  
  List cart = [];
  double totalPrice;
  int totalQuantity;
  bool fetchData = false;
  void getData()async{
    print("get is called");
    Directory directory = await getApplicationDocumentsDirectory();
    File file3 = File('${directory.path}/token.txt');
    token = await file3.readAsString();
    var result = await http.get('$path/auth/me',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
      );
    //print(result.body);
    if(result.statusCode == 200)
      {
        Map<String, dynamic> data = jsonDecode(result.body);
        totalPrice = double.parse(data['data']['user']['cart']['totalPrice'].toString()) ;
        totalQuantity = data['data']['user']['cart']['totalQuantity'];
        cart = data['data']['user']['cart']['products'];
        //print(cart);
        for (var item in cart) {
          Map<String, dynamic> temp = {};
          temp['product'] = item['product']['_id'];           
          print("So far so good");
          temp['quantity'] = item['product']['quantity']; 
          pr.add(temp);
        }
        print(pr);
        fetchData = true;
        setState(() { });
      }
    else{
      print("Error occured while getting data");
    }
    
     
  }

  void placeOrder()async{
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
                SizedBox(width: MediaQuery.of(context).size.width*0.1),
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
    print(jsonEncode({
        "products":pr,
        "totalQuantity": totalQuantity,
        "totalPrice": totalPrice,
        "status": "created"
      }));
    var result = await http.post('$path/order',
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'products':pr,
        'totalQuantity': totalQuantity,
        'totalPrice': totalPrice,
        'status': "created"
      })
    );
    print(result.body);
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
            Text("Ordered")
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
      Future.delayed(Duration(milliseconds: 2000)).then((onValue){
        Navigator.pop(context);
      }
    );  
  }
  
  @override
  void initState() {
    // TODO: implement initSta
    print("cart is called ");
    super.initState();
    var razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    fetchData = false;
    getData();
  }
  
  void handlerPaymentSuccess(){
    print("Pament success");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure(){
      print("Pament error");
      Toast.show("Pament error", context);
  }

  void handlerExternalWallet(){
      print("External Wallet");
      Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black,),
        title: Text("Cart", style: TextStyle(color: Colors.black)),
      ),
      body: 
      fetchData?            
          
      Column(
        children: [                       
          Expanded(
            child: ListView(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: fetchData?cart.length:0,
                itemBuilder: (context, position) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(14)),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage("assets/burger.png"))),
                            ),
                            Expanded(
                              child: Container(                                
                                padding:  EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.values[1],
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 8, top: 4),
                                      child: Text(
                                        "${cart[0]['product']['name']}",
                                        maxLines: 2,
                                        softWrap: true,
                                        style: TextStyle(fontSize:14,fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height*0.02
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "${cart[0]['product']['price']}",
                                              style: TextStyle(fontSize: 14)
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: Row(
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     crossAxisAlignment: CrossAxisAlignment.end,
                                          //     children: <Widget>[
                                          //       Icon(
                                          //         Icons.remove,
                                          //         size: 24,
                                          //         color: Colors.grey.shade700,
                                          //       ),
                                          //       Container(
                                          //         color: Colors.grey.shade200,
                                          //         padding: const EdgeInsets.only(
                                          //             bottom: 2, right: 12, left: 12),
                                          //         child: Text(
                                          //           "1",
                                                  
                                          //         ),
                                          //       ),
                                          //       Icon(
                                          //         Icons.add,
                                          //         size: 24,
                                          //         color: Colors.grey.shade700,
                                          //       )
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 100,
                            )
                          ],
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.topRight,
                      //   child: Container(
                      //     width: 24,
                      //     height: 24,
                      //     alignment: Alignment.center,
                      //     margin: EdgeInsets.only(right: 10, top: 8),
                      //     child: Icon(
                      //       Icons.close,
                      //       color: Colors.white,
                      //       size: 20,
                      //     ),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.all(Radius.circular(4)),
                      //         color: Colors.green),
                      //   ),
                      // )
                    ],
                  );
                },
                
              )
            ],
        ),
          ),
      
          //Spacer(),

          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Row(
          //     children: [
          //       Image.asset('assets/discount.png' , height: 30 , width: 30,),
          //       SizedBox(width: 20,),
          //       Text("Do You Have a discount code ?"),

          //     ],
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
          //   child: TextField(

          //     decoration: new InputDecoration.collapsed(
          //         hintText: 'Enter Code'
          //     ),
          //   ),
          // ),

          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Text("Total",style: TextStyle(fontSize:14,fontWeight: FontWeight.w500)),
                  Spacer(),
                  Text(totalPrice.toString())
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                        child: Text('Order',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat')),
                      ),
                      onTap: () async{
                        await placeOrder();
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentModePage()));
                      }
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 20,),

        ],

      ):
      AlertDialog(
          title:Row( 
            children:<Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.lightBlue[100], 
                //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                strokeWidth: 6.0,
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.1),
              Text("Loading")
            ]
          )
          )
    );
  }
}

//   createCartList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       primary: false,
//       itemBuilder: (context, position) {
//         return createCartListItem();
//       },
//       itemCount: 5,
//     );
//   }

//   createCartListItem() {
//     return Stack(
//       children: <Widget>[
//         Container(
//           margin: EdgeInsets.only(left: 16, right: 16, top: 16),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(16))),
//           child: Row(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(14)),
//                     color: Colors.blue.shade200,
//                     image: DecorationImage(
//                         image: AssetImage("assets/burger.png"))),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.only(right: 8, top: 4),
//                         child: Text(
//                           "Burger",
//                           maxLines: 2,
//                           softWrap: true,
//                           style: TextStyle(fontSize: 14)
//                         ),
//                       ),

//                       Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "\Rs.100.00",
//                                 style: TextStyle(fontSize: 14)
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.remove,
//                                     size: 24,
//                                     color: Colors.grey.shade700,
//                                   ),
//                                   Container(
//                                     color: Colors.grey.shade200,
//                                     padding: const EdgeInsets.only(
//                                         bottom: 2, right: 12, left: 12),
//                                     child: Text(
//                                       "1",
                                     
//                                     ),
//                                   ),
//                                   Icon(
//                                     Icons.add,
//                                     size: 24,
//                                     color: Colors.grey.shade700,
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 flex: 100,
//               )
//             ],
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: Container(
//             width: 24,
//             height: 24,
//             alignment: Alignment.center,
//             margin: EdgeInsets.only(right: 10, top: 8),
//             child: Icon(
//               Icons.close,
//               color: Colors.white,
//               size: 20,
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(4)),
//                 color: Colors.green),
//           ),
//         )
//       ],
//     );
//   }
  
// }

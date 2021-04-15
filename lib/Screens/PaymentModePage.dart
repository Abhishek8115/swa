import 'package:flutter/material.dart';


class PaymentModePage extends StatefulWidget {
  @override
  _PaymentModePageState createState() => _PaymentModePageState();
}

class _PaymentModePageState extends State<PaymentModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff62319E),
        title: Text("Payment Mode"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                //color: Colors.white,
                //width: 200,
                //height: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/wallet.png" , width: 50 , height: 50,),
                            SizedBox(width: 30,),
                            Column(
                              children: [
                                Text("Credit Wallet" , style: TextStyle(color: Colors.indigo , fontSize: 20),),
                                SizedBox(height: 10,),
                                Text("Wallet Balance : 300"),

                              ],
                            )
                          ],
                        ),
                      ),

                      Text("+ Add Money to Wallet" , style: TextStyle(color: Colors.black , fontSize: 16),),

                    ],
                  ),
                ),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                //color: Colors.white,
                //width: 200,
                //height: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/creditcard.png" , width: 50 , height: 50,),
                            SizedBox(width: 30,),
                            Text("Add a Debit/Credit Card" , style: TextStyle(color: Colors.indigo , fontSize: 20),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Container(
                //color: Colors.white,
                //width: 200,
                //height: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/cash.png" , width: 50 , height: 50,),
                            SizedBox(width: 30,),
                            Text("Cash" , style: TextStyle(color: Colors.indigo , fontSize: 20),),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )




          ],
        ),
      ),
    );
  }
}

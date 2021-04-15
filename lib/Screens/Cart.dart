import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

Size size;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          backgroundColor: Colors.purple[700],
        ),
        body: Column(
          children: <Widget>[
            Item(),
            _buildCartSummary(context),
          ],
        ));
  }
}

class Item extends StatelessWidget {
  const Item({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height - 225,
      child: ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, itemCount) {
        return AspectRatio(
          aspectRatio: 5 / 1,
          child: Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.vignette_rounded, color: Colors.green),
                        SizedBox(width: size.width*0.02),
                        Text("Samosa",
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025)),
                      ],
                    ),
                    Text("\u20b9 50")
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.height * 0.02),
                child: AspectRatio(
                  aspectRatio: 6 / 3.8,
                  child: Container(
                    //height: ,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(size.height * 0.02),
                        color: Colors.pink[50],
                        border:
                            Border.all(color: Colors.pink[200], width: 1)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                              child: Text("-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.pink[300]))),
                          Text("1",
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          InkWell(
                              child: Text("+",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.pink[300])))
                        ]),
                  ),
                ),
              )
            ],
          )),
        );
      }),
    );
  }
}
  _buildCartSummary(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(size.width* 0.03, size.height*0.0,size.width* 0.03, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sub Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              Text(
                '\u20b9 480',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ],
          ),
          // SizedBox(height: 10.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       'Taxes (absorbed by you)',
          //       style: TextStyle(fontSize: 15.0),
          //     ),
          //     Text(
          //       '\u20b9 40',
          //       style: TextStyle(fontSize: 15.0),
          //     ),
          //   ],
          // ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                '\u20b9 200',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          MaterialButton(
            onPressed: () {
              print("Processing payment");
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   builder: (context) => SingleChildScrollView(
              //     child: Container(
              //       padding: EdgeInsets.only(
              //           bottom: MediaQuery.of(context).viewInsets.bottom),
              //       child: Text("Hii"),
              //     ),
              //   ),
              // );
            },
            height: 35.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            minWidth: double.infinity,
            child: Text(
              'PROCESS PAYMENT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            color:Colors.purple[700],
          ),
          //SizedBox(height: 15.0),
        ],
      ),
    );
  }


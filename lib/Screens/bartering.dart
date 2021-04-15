import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'map.dart';
import 'scrollbartering.dart';
class Bartering extends StatefulWidget {
  @override
  _BarteringState createState() => _BarteringState();
}

class _BarteringState extends State<Bartering> {
  var data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonkeeper.com/b/RLLA"),
        headers: {
          "Accept": "application/json"
        }
    );
    this.setState(() {
      data = jsonDecode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    //this.getData();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),

      body: SlidingUpPanel(
        maxHeight: 400,

        panelBuilder: (scrollController)=>buildSlidingPanel(
            scrollController:scrollController
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
            return  GestureDetector(
              child: Container(

                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Color(0xffE9E9E9),

                  child: Column(
                    children: <Widget>[
                      SizedBox(height:10,
                      ),
                      Container(
                        height: 250,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                height:100,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image:  NetworkImage(data[index]["image"]),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding:EdgeInsets.fromLTRB(10, 20, 20, 0),
                              child: Text(
                                "${data[index]["name"]}-${data[index]["ownername"]}",
                                style: TextStyle(

                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),

                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Text(
                                    " in need of ${data[index]["inneedof"]}",
                                    style: TextStyle(

                                        fontWeight: FontWeight.w300,

                                        fontSize: 20

                                    ),

                                  ),
                                ),

                                SizedBox(width: 40),
                                Padding(padding:EdgeInsets.all(10),



                                  child: RaisedButton(onPressed: (){
                                    bd.add(Barteringdata(
                                      data[index]["name"],
                                      data[index]["inneedof"],
                                      true,
                                    ));


                                  },
                                    child: Text("Add"),
                                    textColor: Colors.white,
                                    color: Color(0xff62319E),
                                  ),
                                )


                              ],
                            )



                          ],),
                      ),
                    ],
                  )

              ),
            );
          },
        ),
      ),

    );
  }
}
Widget buildSlidingPanel({
  @required ScrollController scrollController,
})=>scrollbarsale();


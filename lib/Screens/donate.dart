import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'map.dart';
import 'scrollfreshsale.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  var data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonkeeper.com/b/BU23"),
        headers: {"Accept": "application/json"});
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      body: SlidingUpPanel(
        maxHeight: 400,
        panelBuilder: (scrollController) =>
            buildSlidingPanel(scrollController: scrollController),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Color(0xffE9E9E9),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 250,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(data[index]["image"]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Text(
                                    "${data[index]["name"]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: RaisedButton(
                                    onPressed: () {
                                      itemData.add(ItemData(
                                        data[index]["name"],
                                        data[index]["dp"],
                                        true,
                                      ));
                                    },
                                    child: Text("Donate"),
                                    textColor: Colors.white,
                                    color: Color(0xff62319E),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}

Widget buildSlidingPanel({
  @required ScrollController scrollController,
}) =>
    scrollfreshsale();

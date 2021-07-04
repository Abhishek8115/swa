import 'dart:convert';
import 'package:swap/Screens/UserScreens/UserMyPostDetails.dart';
import 'package:swap/Widgets/CategoriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//List productList = [];
class MyPosts_User extends StatefulWidget {
List pl, catList;
MyPosts_User ({ Key key, this.pl , this.catList}): super(key: key);
  
  @override
  MyPosts_UserState createState() => MyPosts_UserState();
}

class MyPosts_UserState extends State<MyPosts_User> {
  var data;
  bool productFlag = false;
  Future<String> getData() async {
    Directory directory = await getApplicationDocumentsDirectory(); 
    File file3 = File('${directory.path}/token.txt');
    String token = await file3.readAsString();
    http.Response  response = await http.get('$path/product/my_products',
      headers:{
        "Content-Type": "application/json",
        "Authorization":"Bearer $token"
      }
    );
    Map<String, dynamic> prodlst = {};   
    prodlst = jsonDecode(response.body);
    print(prodlst);
    List temp = prodlst['data']['products'];
    widget.pl = temp;
    http.Response  result = await http.get('$path/category',);   
    Map<dynamic, dynamic> catlst = jsonDecode(result.body);
    print('getData called');
    print(widget.catList);
    setState(() {
      print("setState called");      
      productFlag = true;
      //Navigator.pop(context);
    });
    
  }
  

  @override
  void initState() {
    super.initState();
    //print(widget.pl);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading:  true,
        backgroundColor: Colors.white,
        title:Text("My Post", style: TextStyle(color: Colors.black)),
      ),
      body:
      //productFlag?
        RefreshIndicator(
          onRefresh: () {
              getData();
              return Future.delayed(
                Duration(seconds: 1),
                () {
                },
              );
            },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(size.width*0.00, 0, 0, size.height*0.02),
                  child:GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: size.width*0.02,
                      mainAxisSpacing: 0.0,
                      crossAxisCount: 2,
                      childAspectRatio: 1
                      ),
                    itemCount: widget.pl.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){ 
                          print("catList :${widget.catList}");
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>UserPostItemDetail(details: widget.pl[index], 
                          categoryList: widget.catList)));
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, size.height*0.01, 0, 0),
                          child: Container(
                            //margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            height: size.height*0.4,
                            width: size.width*0.5,
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
                            borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                          children: <Widget>[
                            Padding(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.0),
                              child: Center(
                                // height: size.height*15,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, size.height*0.02, 0, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/Rhombus.gif',
                                      image: widget.pl[index]['image'],
                                      fit: BoxFit.cover,
                                      height: size.height*0.16,
                                    ),
                                  ),
                                ),
                                ),
                              ),
                              Text(widget.pl[index]['name'],
                              maxLines:2,
                              style: TextStyle(fontSize:14,fontWeight: FontWeight.w500),),
                              Center(
                                child: Text(widget.pl[index]['price'].toString(), style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w600, 
                                  fontSize: size.height*0.02)),
                                ),                             
                              ],
                            ),
                            ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swap/Screens/BusinessScreens/AddItems.dart';
import 'package:swap/Screens/BusinessScreens/AddPost.dart';
import 'package:swap/Screens/EditSpace.dart';
class MyPosts_User extends StatefulWidget {
  @override
  _MyPosts_BusinessState createState() => _MyPosts_BusinessState();
}

class _MyPosts_BusinessState extends State<MyPosts_User> {
  
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override  
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: size.height*0.2,
        width:size.width*0.2,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.add, size: size.height*0.05,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AddPost()));
                setState(() {
                  
                });
                //_animationController.forward();
                print("Viola");},
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "My Posts",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
            physics: BouncingScrollPhysics(), 
            itemCount: 7,//data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                background:Container(
                  color: Colors.red,
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                confirmDismiss: (direction) async {                    
                    final bool res = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                                "Are you sure you want to delete ?"),
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
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  setState(() {
                                   
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    return res;
                },
                onDismissed: (direction){print("Deleted");},
                key: Key(index.toString()),
                child:Padding(
                padding: EdgeInsets.fromLTRB(size.width*0.04, size.height*0.02, size.width*0.04, 0),
                child: Container(
                height: size.height*0.3,
                width: 400,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.04),
                            child: CircleAvatar(
                              radius: size.height*0.05,
                              backgroundImage: AssetImage('assets/burger.png'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, size.width*0.04, 0),
                            child: Text("Burger",style: TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap:(){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>EditPost()));},
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, size.width*0.1, 0),
                          child: Icon(Icons.edit),
                        ),
                      ),
                    // Column(
                    //   children: <Widget>[
                    //    Icon(Icons.shopping_cart),
                    //    SizedBox(
                    //      height: size.height*0.01
                    //    ),
                    //    Text("Add to cart", style: TextStyle(fontSize: 10)),
                    //   ],
                    // ),                            
                    ],                        
                  ),
                  Expanded(
                    flex: 1,
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(size.width*0.04, 0, size.width*0.04, 0),
                        child: new Text(
                          "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " + 
                          "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " + 
                          "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" + 
                          "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" + 
                          "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " ,     
                          style: new TextStyle(
                            fontSize:13,color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),                 
                ],
              ),
            )
          )
        );
      },
    )
  );
  }

  Widget Posts_Card() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            child: Column(
              children: [
                Text("Info 1"),
                Text("Info 1"),
                Text("Info 1"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

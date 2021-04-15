import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map.dart';

class scrollfriendlysale extends StatefulWidget {
  const scrollfriendlysale({
    Key key,
    this.scrollController,
  }):super(key:key);
  final ScrollController scrollController;
  @override
  _scrollfriendlysaleState createState() => _scrollfriendlysaleState();
}

class _scrollfriendlysaleState extends State<scrollfriendlysale> {
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
                          Text("Get it from a friend",
                              style: TextStyle(
                                  fontSize:30
                              )
                          ),Text("Only Available for two",
                              style: TextStyle(
                                  fontSize:20,
                                  color: Color(0xffD8D8D8)
                              )
                          ),]

                    ),
                      Icon(Icons.fullscreen_exit_outlined,size: 40,color: Color(0xff62319E),),]),
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
                                  children: [Text(fd[index].Name,
                                    style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                    Text("for  ${fd[index].f}",)
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
                                          if (fd[index].Counter > 1) {
                                            fd[index].Counter--;
                                          }
                                          else if (fd[index].Counter == 1) {
                                            fd.removeAt(index);

                                          }
                                        });
                                      },
                                      color: Colors.green,
                                    ),
                                    Text(fd[index].Counter.toString()),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      color: Colors.green,
                                      onPressed: () {
                                        setState(() {
                                          fd[index].Counter++;
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
                Text("Options"),
                Container(
                  height: 40,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color:Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Container( child:Row(
                        children: [
                          Icon(
                              Icons.location_on

                          ),
                          Column(
                            children: [
                              Text("Meetup",style: TextStyle(color: Colors.blue),),
                              Text("in his home",style: TextStyle(color: Colors.black),),

                            ],
                          ),


                        ],
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
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0),
                        color: Color(0xff62319E),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: Center(
                              child: Text('Confirm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                            onTap: () {
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

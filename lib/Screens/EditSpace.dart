import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Edit_Space extends StatefulWidget {
  @override
  _Edit_SpaceState createState() => _Edit_SpaceState();
}

class _Edit_SpaceState extends State<Edit_Space> {


  TextEditingController bikecont = new TextEditingController();
  TextEditingController carcont = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Edit Space", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,

      ),

      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(size.height*0.01),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.5,
                  blurRadius: 3,
                ),],
              ),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: size.height*0.0, left: size.width*0.05 ,right: size.width*0.1 ),
                    child: Row(
                      children: <Widget>[
                        Icon(MdiIcons.carSports, size: size.height*0.05, color: Colors.redAccent[700],),
                        Text("  Cars : ", style: GoogleFonts.palanquin(
                            fontSize: size.aspectRatio*40, fontWeight: FontWeight.bold
                        ),),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: 60,
                            height: 20,
                            child: TextField(
                              controller: carcont,
                            ),
                          ),
                        )
                        //Text("10", style: TextStyle(fontSize: size.aspectRatio*40, fontWeight: FontWeight.w400),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.05 ,right: size.width*0.1 ),
                    child: Row(
                      children: <Widget>[
                        Icon(MdiIcons.motorbike, size: 40, color: Colors.lightBlue,),
                        Text("  Bike : ", style: GoogleFonts.palanquin(
                            fontSize: size.aspectRatio*40, fontWeight: FontWeight.bold
                        ),),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 20,
                            width: 60,
                            child: TextField(
                              controller: bikecont,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text("Your Timings",style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)),
          ),
          Expanded(
            //height: size.height*0.6,
            //color: Colors.blue.withOpacity(0.1),
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, itemIndex){
                  return Card(
                    shadowColor: Colors.black,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    //color: Colors.greenAccent[100],
                    child: ListTile(
                      //contentPadding: EdgeInsets.all(size.height*0.01),
                      leading: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text("${itemIndex+1}.", style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w300)),
                      ),
                      trailing: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: (){

                              //Show Time Dialog & Text Field for rate edit

                            },
                            child: Icon(Icons.edit)),
                      ),

                      title: Text("9:00 AM    to   12:00 PM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18)),
                      subtitle: Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Text("Rate : ", style: TextStyle(color: Colors.black54, fontSize: 16)),
                            Text("Rs. 50", style: TextStyle(color: Colors.black54, fontSize: 16,)),
                          ],
                        ),
                      ),

                    ),
                  );
                }
            ),
          ),
        ],
      ),

    );
  }
}

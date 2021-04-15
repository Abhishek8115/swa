import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AddItemsFlashSale extends StatefulWidget {
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<AddItemsFlashSale> with TickerProviderStateMixin {

  AnimationController _animationController;
  File tempImage;
  PickedFile  _image;

  List<bool> flags = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  File image;  
  String parkingImageUrl;
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    _animationController.repeat();
  }


  _imgFromCamera() async {

    PickedFile image = await ImagePicker.platform.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      flags[0]=true;
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await  ImagePicker.platform.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );   
    setState(() {
      flags[0]=true;
      _image = image;
    });
  }




  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Add Post", style: TextStyle(color: Colors.black),),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, size.height*0.05, 0, size.height*0.02),
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: _image != null
                    ? 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_image.path),
                        width: 200,
                        height: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo[300],
                      //borderRadius: BorderRadius.circular(100),
                      shape: BoxShape.circle,),
                      
                  width: 200,
                  height: 150,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text("Add an image:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54)),
            child: TextFormField(
                validator: (val) {
                  setState(() {
                    //val.isEmpty ? error = true : error = false;
                  });
                  return null;
                },
                onTap: () {
                  setState(() {
                   
                  });
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText:" Name",
                  errorMaxLines: 3,                      
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: size.height*0.02),                        
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54)),
            child: TextFormField(
                onTap: () {
                  setState(() {
                   
                  });
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText:" Description",
                  errorMaxLines: 3,                      
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: size.height*0.02),                        
                )),
          ),
          InkWell(
            onTap: () async {
              showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: AlertDialog(
                    title:Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children:<Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.indigo, 
                          valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                          strokeWidth: 6.0,
                        ),
                        SizedBox(width: size.width*0.1),
                        Text("Loading")
                      ]
                    )
                  ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 300),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {});
              print("Done");
              // Future.delayed(Duration(milliseconds: 3000)).then((onValue)=>
              //   //Navigator.pop(context)
              //   print("Done")
              // );
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(size.width*0.3, 0, size.width*0.3, 0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Color(0xff62319E),
                    borderRadius: BorderRadius.circular(100.0)),
                child: Center(
                  child: Text('Done',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'
                    )
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
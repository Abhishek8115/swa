import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class EditPost extends StatefulWidget {
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> with TickerProviderStateMixin {

  AnimationController _animationController;
  File tempImage;
  PickedFile  _image;
  bool dateSelected = false;
  bool categorySelected = false;
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
  String imageUrl;
  String dropdownValue;
  DateTime selectedDate;
  String selectedCategory ;
  String selectedDateString ;

  TextEditingController name = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController quantity = new TextEditingController();
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
    selectedDate = DateTime.now();
    selectedDateString = DateTime.now().toIso8601String();
  }

  void addItems()async
  {
    print(name.text.isEmpty);
    print(description.text.isEmpty);
    print(price.text.isEmpty);
    print(!dateSelected);
    print(!categorySelected);
    //print("selected category is : $selectedCategory");
    if( quantity.text.isEmpty || name.text.isEmpty || description.text.isEmpty || price.text.isEmpty || !dateSelected || !categorySelected)
    {
      return(
        Toast.show("Please fill each entry", context,
          duration: 1,
          gravity: 0,
          backgroundColor: Colors.indigo[200])
      );
    }
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/token.txt');
    String token = await file.readAsString();
    double dPrice = double.parse(price.text.trim());
    print("price : $dPrice");
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
                valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
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
    print(selectedDate.toIso8601String());
    http.Response response = await http.post("$path/product",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "name": name.text.trim(),
        "description": description.text.trim(),
        "price": dPrice,
        "category": selectedCategory,
        "image": "data:image/jpeg;base64,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",
        "expiration": selectedDate.toIso8601String(),
        "quantity": int.parse(quantity.text.trim()),
      })  
    );
    print(response.body);
    Navigator.pop(context);
    if (response.statusCode ==200) {
      return(
          Toast.show("Product Added ", context,
            duration: 1,
            gravity: 0,
            backgroundColor: Colors.indigo[200])
        );
    }
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
  

  Future<void> _selectDate(BuildContext context) async {
    dateSelected = true;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedDateString = "${picked.day.toString()} / ${picked.month.toString()} / ${picked.year.toString()}";
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
        title: Text("Add Item", style: TextStyle(color: Colors.black),),
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
                controller: name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText:"  Name ",
                  errorMaxLines: 3,                      
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: size.height*0.02),                        
                )),
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
                keyboardType: TextInputType.phone,
                controller: price,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixText: "  \$",
                  hintText:"Price",
                  errorMaxLines: 3,                      
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: size.height*0.02),                        
                )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
              value: dropdownValue,
              //decoration: InputDecoration.collapsed(hintText: ''),
              onChanged: (String newValue) {
                setState(() {
                  categorySelected = true;
                  dropdownValue = newValue;
                  selectedCategory = newValue;
                });
              },
              hint: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Category",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              items: <String>['First', 'Second', 'Third', 'Fourth']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          ),
            )
          ),
          GestureDetector(
            onTap:()async{ await _selectDate(context);},            
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black54)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  dateSelected?Center(child: Text('$selectedDateString')):Text("Tap to slect Date"),
                  Icon(Icons.date_range_outlined)
                ],
              ),
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
                onTap: () {
                  setState(() {
                   
                  });
                },
                keyboardType: TextInputType.phone,
                controller: quantity,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText:"   Quantity",
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
                controller: description,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText:"   Description",
                  errorMaxLines: 3,                      
                  hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: size.height*0.02),                        
                )),
          ),
          
          InkWell(
            onTap: () async {
              await addItems();
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
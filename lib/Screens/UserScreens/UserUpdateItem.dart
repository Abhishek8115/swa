import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:swap/global.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:toast/toast.dart';

class UserUpdateItem extends StatefulWidget {
  @override
  List pl, catList;
  String id;
  UserUpdateItem({ Key key, this.catList, this.id}): super(key: key);
  _UserUpdateItemState createState() => _UserUpdateItemState();
}
List<String> categoriesLists = [];
class _UserUpdateItemState extends State<UserUpdateItem> with TickerProviderStateMixin {

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
    //print("catList : ${widget.categoryList}");
    //catLists = widget.catList;
    categoriesLists.clear();
    for(var name in widget.catList)
    {
      categoriesLists.add(name['name']);
    }
  }

    void updateItems()async
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
    //String selCatId = categories[selectedIndex]['id'];
    //String selCatId = 
    print("$path/product/${widget.id}");
    http.Response response = await http.put("$path/product/${widget.id}",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "name": name.text.trim(),
        "description": description.text.trim(),
        "price": dPrice,
        "category": selectedCategory,
        "image": "data:image/jpeg;base64,GiQ7QDs0PyAAAA",
        "expiration": selectedDate.toIso8601String(),
        "quantity": int.parse(quantity.text.trim()),
      })  
    );
    Navigator.pop(context);
    print(response.body);
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
            title:Column( 
              children:<Widget>[
                // CircularProgressIndicator(
                //   backgroundColor: Colors.indigo, 
                //   //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                //   strokeWidth: 6.0,
                // ),
                //SizedBox(width: MediaQuery.of(context).size.width*0.05),
                Image.asset("assets/successful.gif",
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.05),
                Text("Product updated")
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
    Future.delayed(Duration(milliseconds: 2000)).then((onValue)=>
                Navigator.pop(context)
                
              );
    // Navigator.pop(context);
    // Navigator.pop(context);
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
        title: Text("Update Item", style: TextStyle(color: Colors.black),),
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
                  //selectedIndex = categoriesLists.indexOf(selectedCategory);
                  print(selectedCategory);
                });
              },
              hint: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Category",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              items: categoriesLists.map<DropdownMenuItem<String>>((String value) {
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
              await updateItems();
              showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.5),
                transitionBuilder: (context, a1, a2, widget) {
                  return Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: AlertDialog(
                      title:Column( 
                        children:<Widget>[
                          // CircularProgressIndicator(
                          //   backgroundColor: Colors.indigo, 
                          //   //valueColor: _animationController.drive(ColorTween(begin: Colors.indigo, end: Colors.deepPurple[100])),                  
                          //   strokeWidth: 6.0,
                          // ),
                          //SizedBox(width: MediaQuery.of(context).size.width*0.05),
                          Image.asset("assets/successful.gif",
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.05),
                          Text("Product deleted")
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
              Future.delayed(Duration(milliseconds: 2000)).then((onValue){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);   
                print("All pops are called");     
              }); 
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
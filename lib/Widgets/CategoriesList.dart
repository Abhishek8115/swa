import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {

  List categories;
  CategoriesList({Key key, this.categories}): super(key:key);
 
  @override
  State<StatefulWidget> createState() => _CategoriesListState();
}
Size size;
int selectedIndex;
class _CategoriesListState extends State<CategoriesList> {

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
    // categories = ["Women's Clothing",
    //   "Men's Clothing", 
    //   "Kid's Wear",
    //   "Non-Food",
    //   "Cooked Food",
    //   "Electronics"
    // ];
  }
  @override
  Widget build(BuildContext context) {
    print(widget.categories);
    print(widget.categories.length);
    size = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
          child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories==null?0:widget.categories.length,
        itemBuilder: (BuildContext context, index){
          return Padding(
            padding:  EdgeInsets.fromLTRB(0, size.height*0.01,size.width*0.02,size.height*0.005),
            child: GestureDetector(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                height: size.height*0.0,
                decoration: BoxDecoration(
                  color: index==selectedIndex?Colors.grey[200]:Colors.white,
                  borderRadius: BorderRadius.circular(size.height*0.05),
                  boxShadow: index==selectedIndex?[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ]:null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.height*0.01),
                  child: Center(child: Text(widget.categories[index]['name'])),
                ),
              ),
            ),
          );
      }),
    );
  }
}
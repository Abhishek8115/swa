import 'package:flutter/material.dart';
class ItemData{
  String Name;
  var price;
  bool ShouldVisible;
  int Counter=1;

  ItemData(
      String Name,
      var price,
      bool ShouldVisible
      )
  {
    this.Name=Name;
    this.price=price;
    this.ShouldVisible=true;
  }
}
class Barteringdata{
  String Name;
  String need;
  bool ShouldVisible;
  int Counter=1;
  Barteringdata(String Name,String need,bool ShouldVisible)
  {
    this.Name=Name;
    this.need=need;
    this.ShouldVisible=true;
  }
}
class Friend{
  String Name;
  String f;
  bool ShouldVisible;
  int Counter=1;
  Friend(String Name,String need,bool ShouldVisible)
  {
    this.Name=Name;
    this.f=need;
    this.ShouldVisible=true;
  }

}

List<ItemData> itemData = [
  ItemData("Burger",4.99,true),
];
List <Barteringdata>bd=[
  Barteringdata("Rice", "curry", true)
];
List<Friend> fd=[
  Friend(
      "rice","2",true
  )
];


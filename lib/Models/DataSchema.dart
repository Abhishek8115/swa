class Cart{
  String itemName;
  String itemDescription;
  int itemCount;

  Cart(String name, String description, int count)
  {
    this.itemName = name;
    this.itemDescription = description;
    this.itemCount = count;
  }
}
class PostSchema{
  String itemName;
  String itemDescription;
  String image;
  PostSchema(String itemName, String itemDescription,   String image)
  {
    this.itemName = itemName;
    this.itemDescription = itemDescription;
    this.image = image;
  }
}
class ItemData{
  String itemName;
  double itemPrice;
  double discountedPrice;
  DateTime expirationDate;

  Cart(String name, double price, double dPrice, DateTime eDate)
  {
    this.itemName = name;
    this.itemPrice = price;
    this.discountedPrice = dPrice;
    this.expirationDate = eDate;
  }
}


class Products {
  late String productName;
  late String productPrice;
  late String imageUrl;

  Products(
    String productName,
    String productPrice,
    String imageUrl,
  ) {
    this.productName = productName;
    this.productPrice = productPrice;
    this.imageUrl = imageUrl;
  }

  Products.fromJson(Map<String, dynamic> json)
      : productName = json['productName'],
        productPrice = json['productPrice'],
        imageUrl = json['imageUrl'];

  Map<String, dynamic> toJson() => {
        'productName': productName,
        'priproductPricece': productPrice,
        'imageUrl': imageUrl,
      };
}

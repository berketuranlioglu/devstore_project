class Products {
  late String name;
  late String price;
  late String imageUrl;

  Products(
    String name,
    String price,
    String imageUrl,
  ) {
    this.name = name;
    this.price = price;
    this.imageUrl = imageUrl;
  }

  Products.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        imageUrl = json['imageUrl'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
      };
}

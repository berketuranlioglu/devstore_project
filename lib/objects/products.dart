class Products {
  late String productBrand;
  late String category;
  late Map<String, Map<String, dynamic>> comments;
  late String details;
  late dynamic imageURL;
  late dynamic location;
  late String overview;
  late double previousPrice;
  late String productName;
  late double rating;
  late int ratingCount;
  late double salePrice;
  late String sellerName;


  Products(
      String productBrand,
      String category,
      Map<String, Map<String, dynamic>> comments,
      String details,
      dynamic imageURL,
      dynamic location,
      String overview,
      double previousPrice,
      String productName,
      double rating,
      int ratingCount,
      double salePrice,
      String sellerName,
  ) {
    this.productBrand = productBrand;
    this.category = category;
    this.comments = comments;
    this.details = details;
    this.imageURL = imageURL;
    this.location = location;
    this.overview = overview;
    this.previousPrice = previousPrice;
    this.productName = productName;
    this.rating = rating;
    this.ratingCount = ratingCount;
    this.salePrice = salePrice;
    this.sellerName = sellerName;
  }

  Products.fromJson(Map<String, dynamic> json)
      : productBrand = json['productBrand'],
        category = json['category'],
        comments = json['comments'],
        details = json['details'],
        imageURL = json['imageURL'],
        location = json['location'],
        overview = json['overview'],
        previousPrice = json['previousPrice'],
        productName = json['productName'],
        rating = json['rating'],
        ratingCount = json['ratingCount'],
        salePrice = json['salePrice'],
        sellerName = json['sellerName'];

  Map<String, dynamic> toJson() => {
    'productBrand': productBrand,
    'category': category,
    'comments': comments,
    'details': details,
    'imageURL': imageURL,
    'location': location,
    'overview': overview,
    'previousPrice': previousPrice,
    'productName': productName,
    'rating': rating,
    'ratingCount': ratingCount,
    'salePrice': salePrice,
    'sellerName': sellerName,
  };
}

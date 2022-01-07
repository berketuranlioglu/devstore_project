class Categories {
  late var products;
  late var productReference;

  Categories(
      var products,
      var productReference,
      ) {
    this.products = products;
    this.productReference = productReference;
  }

  Categories.fromJson(Map<String, dynamic> json)
      : products = json['products'],
        productReference = json['productReference']
  ;

  Map<String, dynamic> toJson() => {
    'products': products,
    'productReference': productReference,

  };
}
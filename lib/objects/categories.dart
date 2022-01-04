class Categories {
  late var products;

  Categories(
      var products,
      ) {
    this.products = products;
  }

  Categories.fromJson(Map<String, dynamic> json)
      : products = json['products']
  ;

  Map<String, dynamic> toJson() => {
    'products': products,

  };
}
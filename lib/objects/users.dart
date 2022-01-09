class Users {
  late String nameSurname;
  late String username;
  late bool isActive;
  late String? imageUrl;
  late String password;
  late String userToken;
  late String email;
  late String phone;
  late double rating;
  late var productReference;

  Users(
      String nameSurname,
      String username,
      bool isActive,
      String imageUrl,
      String password,
      String userToken,
      String email,
      String phone,
      double rating,
      var productReference,
  ) {
    this.nameSurname = nameSurname;
    this.username = username;
    this.isActive = isActive;
    this.imageUrl = imageUrl;
    this.password = password;
    this.userToken = userToken;
    this.email = email;
    this.phone = phone;
    this.rating = rating;
    this.productReference;
  }

  Users.fromJson(Map<String, dynamic> json)
      : nameSurname = json['nameSurname'],
        isActive = json['isActive'],
        username = json['username'],
        imageUrl = json['imageUrl'],
        password = json['password'],
        userToken = json['userToken'],
        email = json['email'],
        phone = json['phone'],
        rating = json['rating'],
        productReference = json['productReference'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'nameSurname': nameSurname,
    'isActive': isActive,
    'imageUrl': imageUrl,
    'password': password,
    'userToken': userToken,
    'email': email,
    'phone': phone,
    'rating': rating,
    'productReference': productReference,
      };
}
